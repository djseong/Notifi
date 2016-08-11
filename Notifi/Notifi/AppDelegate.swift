//
//  AppDelegate.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabViewController = CustomizedTabBarViewController()
    var device_token:String = ""
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // set up view controllers
        let onboardingcontroller = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        let navigationcontroller = UINavigationController(rootViewController: onboardingcontroller)
        
        // Set up nsuser
        let defaults = NSUserDefaults.standardUserDefaults()
        
        initNotificationSettings()
        
        let loadingViewController = LoadingViewController(nibName: "LoadingViewController", bundle: nil)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = loadingViewController
        self.window?.makeKeyAndVisible()
        
        
        // check if already logged in to facebook
        //read defaults
        if let id: String = defaults.objectForKey("currentuserfbId") as? String {
            if let firstname: String = defaults.objectForKey("currentuserfirstname") as? String {
                if let picture: String = defaults.objectForKey("currentuserpicture") as? String {
                    print("logged in")
                    print(id)
                    SignifyUserController.sharedInstance.currentUser = SignifyUser(lastName: "unknown", firstName: firstname, imageString: picture, fbId: id)
                    if let bolValue:Bool = defaults.objectForKey("UseMyLocation") as? Bool{
                    SignifyUserController.sharedInstance.currentUser.useLocation = bolValue
                    }else{
                    SignifyUserController.sharedInstance.currentUser.useLocation = false
                    }
                    if let useNotifyList:Bool = defaults.objectForKey("IfUseList") as? Bool{
                        SignifyUserController.sharedInstance.currentUser.useNotifyFriendList = useNotifyList
                    }else{
                         SignifyUserController.sharedInstance.currentUser.useNotifyFriendList = false
                    }
                    if let notifyList: [String] = defaults.objectForKey("SignifyFriendsList") as? [String]{
                        SignifyUserController.sharedInstance.currentUser.notifyFriendList = notifyList
                    }
                    if let homeAddress: String = defaults.objectForKey("HomeAddress") as? String{
                         SignifyUserController.sharedInstance.currentUser.homeAddress = homeAddress
                    }
                    if let phoneNo: String = defaults.objectForKey("PhoneNo") as? String{
                        SignifyUserController.sharedInstance.currentUser.cellPhone = phoneNo
                    }
                    if let lastName: String = defaults.objectForKey("LastName") as? String{
                        SignifyUserController.sharedInstance.currentUser.lastName = lastName
                    }
                    if let emerFirstName: String = defaults.objectForKey("EmerFirstName") as? String{
                        SignifyUserController.sharedInstance.currentUser.emerFirstName = emerFirstName
                    }
                    if let emerLastName: String = defaults.objectForKey("EmerLastName") as? String{
                        SignifyUserController.sharedInstance.currentUser.emerLastName = emerLastName
                    }
                    if let emerCellPhone: String = defaults.objectForKey("EmerPhoneNo") as? String{
                        SignifyUserController.sharedInstance.currentUser.emerCellPhone = emerCellPhone
                    }

                    //User automatically login with user default
                    let apiService = APIService()
                    let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/access/login"),method:"POST",parameters:["facebook_id": id, "password": id])
                    apiService.executeRequest(request, requestCompletionFunction: {respondCode, json in
                        if respondCode/100 == 2 {
                            print("log in successfully")
                            APIServiceController.sharedInstance.populateFriendList()
                            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                            self.window?.rootViewController = self.initTabBarController()
                            self.window?.makeKeyAndVisible()
                            APIServiceController.sharedInstance.updateDeviceToken(self.device_token)
                            
                        }else{
                            print("log in failure")
                            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                            self.window?.rootViewController = navigationcontroller
                            //self.window?.rootViewController = tabViewController
                            self.window?.makeKeyAndVisible()
                        }
                    })

                    
                }
            }
        }
        
        else {
            print("not logged in ")
            navigationcontroller.navigationBar.barTintColor = UIColor.blackColor()
            navigationcontroller.navigationBar.barStyle = UIBarStyle.Black
            navigationcontroller.navigationBar.tintColor = UIColor.whiteColor()
            
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            self.window?.rootViewController = navigationcontroller
            self.window?.makeKeyAndVisible()
        }
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    



    func initNotificationSettings() {
        
        // Safe Action
        let incrementAction = UIMutableUserNotificationAction()
        incrementAction.identifier = "SAFE"
        incrementAction.title = "Safe"
        incrementAction.activationMode = UIUserNotificationActivationMode.Background
        incrementAction.authenticationRequired = true
        incrementAction.destructive = false
        
        // Attention Action
        let decrementAction = UIMutableUserNotificationAction()
        decrementAction.identifier = "ATTENTION"
        decrementAction.title = "Attention"
        decrementAction.activationMode = UIUserNotificationActivationMode.Background
        decrementAction.authenticationRequired = true
        decrementAction.destructive = false
        
        
        // Category
        let counterCategory = UIMutableUserNotificationCategory()
        counterCategory.identifier = "COUNTER_CATEGORY"
        
        // A. Set actions for the default context
        counterCategory.setActions([incrementAction, decrementAction],
                                   forContext: UIUserNotificationActionContext.Default)
        
        // B. Set actions for the minimal context
        counterCategory.setActions([incrementAction, decrementAction],
                                   forContext: UIUserNotificationActionContext.Minimal)
        
        //UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: counterCategory))  // types are UIUserNotificationType members
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: NSSet(object: counterCategory) as? Set<UIUserNotificationCategory>)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)

    }
    
    
    
    func initTabBarController() -> CustomizedTabBarViewController{
        let tabViewController = CustomizedTabBarViewController()

        let nightlyViewController = NightlyViewController()


        let CheckInViewController = checkInViewController()

        let homenavigationController = UINavigationController(rootViewController: nightlyViewController)
        let friendnavigationController = UINavigationController(rootViewController: CheckInViewController)
        
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icon_home_stroke.png"), selectedImage:UIImage(named: "icon_home_full.png") )
        let friendTabBarItem = UITabBarItem(title: "Friends", image:UIImage(named: "icon_friends_stroke.png") , selectedImage: UIImage(named: "icon_friends_full.png"))
        
        homenavigationController.tabBarItem = homeTabBarItem
        friendnavigationController.tabBarItem = friendTabBarItem
        
        let controllers = [homenavigationController,friendnavigationController]
        tabViewController.viewControllers = controllers
        return tabViewController
    }
    
    
    func application(application: UIApplication,
                     openURL url: NSURL,
                             sourceApplication: String?,
                             annotation: AnyObject) -> Bool {
        // The “OpenURL” method allows your app to open again after the user has validated their login credentials.
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            openURL: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        if identifier == "ATTENTION"{
            print("I need attention")
            StatusController.sharedInstance.changeCurrentState(.Attention)
            
            APIServiceController.sharedInstance.updateState(.Attention)
            completionHandler()
            
        }else if identifier == "SAFE"{
            print("I am safe")
            StatusController.sharedInstance.changeCurrentState(.Safe)
            APIServiceController.sharedInstance.updateState(.Safe)
            completionHandler()
        }
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print ("received notification")
        
        //first detect if the notification provided a uuid for a sensor to be alarmed.
        _ = userInfo["aps"]
        print ("aps \(userInfo)")

        
    }
    
    
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        //get device token
          print("deviceToken:",deviceToken)
          device_token = String(deviceToken)
        }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register:", error)
    }
    
}

