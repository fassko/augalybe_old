//
//  AppDelegate.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 30/08/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let tabBarController = UITabBarController()
    //    tabBarController.viewControllers = [navController, storesListNavController, aboutNavController]
    //    tabBarController.tabBar.tintColor = .pink
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    
    return true
  }
}
