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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        
        //Daniel needs to commit /Downloads/montserrat/Montserrat-UltraLight.otf: file. i dont think he did
        
            /*for name in UIFont.familyNames() {
             print(name)
             if let nameString = name as? String
             {
             print(UIFont.fontNamesForFamilyName(nameString))
             }
             }*/

        //do init for tab bar
        initTabBarController()
        
        let onboardingcontroller = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        let navigationcontroller = UINavigationController(rootViewController: onboardingcontroller)
        
        //TODO uncomment this line below to simulate being log in
        //navigationcontroller = UINavigationController(rootViewController: tabViewController)
        navigationcontroller.navigationBar.barTintColor = UIColor.blackColor()
        navigationcontroller.navigationBar.barStyle = UIBarStyle.Black
        navigationcontroller.navigationBar.tintColor = UIColor.whiteColor()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //self.window?.rootViewController = navigationcontroller
        self.window?.rootViewController = tabViewController
        self.window?.makeKeyAndVisible()

        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func initTabBarController(){
        let nightlyViewController = NightlyViewController()
        let switchViewController = SwitchViewController()
        let homenavigationController = UINavigationController(rootViewController: nightlyViewController)
        let friendnavigationController = UINavigationController(rootViewController: UIViewController())
        
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icon_home_stroke.png"), selectedImage:UIImage(named: "icon_home_full.png") )
        let friendTabBarItem = UITabBarItem(title: "Friends", image:UIImage(named: "icon_friends_stroke.png") , selectedImage: UIImage(named: "icon_friends_full.png"))
        let switchTabBarItem = UITabBarItem(title: "swicth", image: nil, selectedImage: nil)
        
        homenavigationController.tabBarItem = homeTabBarItem
        friendnavigationController.tabBarItem = friendTabBarItem
        switchViewController.tabBarItem = switchTabBarItem
        
        let controllers = [homenavigationController,switchViewController,friendnavigationController]
        tabViewController.viewControllers = controllers
        return
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

}

