//
//  AppDelegate.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabViewController = CustomizedTabBarViewController()
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        //do init for tab bar
        //initTabBarController()
        
        let onboardingcontroller = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        let navigationcontroller = UINavigationController(rootViewController: onboardingcontroller)
        
        // Check if already logged in for facebook
        let defaults = NSUserDefaults.standardUserDefaults()
        if let id: String = defaults.objectForKey("currentuserid") as? String {
            print("logged in")
            print(id)
//            let friendtablecontoller = FriendTableViewController(nibName: "FriendTableViewController", bundle: nil)
//            navigationcontroller.pushViewController(friendtablecontoller, animated: true)
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            self.window?.rootViewController = initTabBarController()
            self.window?.makeKeyAndVisible()
        }
        else {
        print("not logged in ")
        //TODO uncomment this line below to simulate being log in
        //navigationcontroller = UINavigationController(rootViewController: WelcomePageViewController(nibName: "WelcomePageViewController",bundle: nil))
        navigationcontroller.navigationBar.barTintColor = UIColor.blackColor()
        navigationcontroller.navigationBar.barStyle = UIBarStyle.Black
        navigationcontroller.navigationBar.tintColor = UIColor.whiteColor()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = navigationcontroller
        //self.window?.rootViewController = tabViewController
        self.window?.makeKeyAndVisible()
        }
        
        FIRApp.configure()
        print(FIRInstanceID.instanceID().token())

        let refreshedToken = FIRInstanceID.instanceID().token()
        print("InstanceID token: \(refreshedToken)")
        
        
        initNotificationSettings()
        // Add observer for InstanceID token refresh callback.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.tokenRefreshNotification),
                                                         name: kFIRInstanceIDTokenRefreshNotification, object: nil)

        
        self.initDatabase()
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    

    func initDatabase() {
        
//        let ref = FIRDatabase.database().reference()
//        
//        let refHandle = ref.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
//            let fullDatabase = snapshot.value as! [String : AnyObject]
//          print("herehere")
//            print(fullDatabase)
//        })
    }

    
    
    // [START refresh_token]
    func tokenRefreshNotification(notification: NSNotification) {
        let refreshedToken = FIRInstanceID.instanceID().token()!
        print("InstanceID token: \(refreshedToken)")
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    // [END refresh_token]


    func initNotificationSettings() {
        
        // increment Action
        let incrementAction = UIMutableUserNotificationAction()
        incrementAction.identifier = "SAFE"
        incrementAction.title = "Safe"
        incrementAction.activationMode = UIUserNotificationActivationMode.Background
        incrementAction.authenticationRequired = true
        incrementAction.destructive = false
        
        // decrement Action
        let decrementAction = UIMutableUserNotificationAction()
        decrementAction.identifier = "ATTENTION"
        decrementAction.title = "Attention"
        decrementAction.activationMode = UIUserNotificationActivationMode.Background
        decrementAction.authenticationRequired = true
        decrementAction.destructive = false
        
        // reset Action
        let resetAction = UIMutableUserNotificationAction()
        resetAction.identifier = "RESET_ACTION"
        resetAction.title = "Reset"
        resetAction.activationMode = UIUserNotificationActivationMode.Foreground
        // NOT USED resetAction.authenticationRequired = true
        resetAction.destructive = true
        
        // Category
        let counterCategory = UIMutableUserNotificationCategory()
        counterCategory.identifier = "COUNTER_CATEGORY"
        
        // A. Set actions for the default context
        counterCategory.setActions([incrementAction, decrementAction, resetAction],
                                   forContext: UIUserNotificationActionContext.Default)
        
        // B. Set actions for the minimal context
        counterCategory.setActions([incrementAction, decrementAction],
                                   forContext: UIUserNotificationActionContext.Minimal)
        
        //UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: counterCategory))  // types are UIUserNotificationType members
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: NSSet(object: counterCategory) as! Set<UIUserNotificationCategory>)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)

    }
    
    
    
    func initTabBarController() -> CustomizedTabBarViewController{
        var tabViewController = CustomizedTabBarViewController()

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
            
        }else if identifier == "SAFE"{
            print("I am safe")
            StatusController.sharedInstance.changeCurrentState(.Safe)
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
        let aps = userInfo["aps"]
        print ("aps \(userInfo)")
//        if let alarmedUuid = aps!["uuid"]  {
//            print ("uuid in question: |\(alarmedUuid)|")
//            //go to the home screen, where the sensors are displayed, and refresh emmediately. The state of alarm is fetched along with the other information about the sensors
//            
//            
//        }
        
    }
    
    
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        print("DeviceToken:", tokenString)
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.Prod)
        print("deviceToken:",deviceToken)
        connectToFcm()
        //UserController.sharedInstance.registerPushToken(tokenString)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register:", error)
        //UserController.sharedInstance.registerPushToken("failed_to_register_for_ios_push_notes")
    }
    func connectToFcm() {
        
        
        FIRMessaging.messaging().connectWithCompletion{(error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
                
//                SignifyUserController.sharedInstance.sendNote([""], alert:"alert", key:"")
                SignifyUserController.sharedInstance.send("wwww")
            }
            
            
        }
        
    }
    
}

