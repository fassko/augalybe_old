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
  
  var mapCoordinator: MapCoordinator?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let mapNavController = AuGalybeNavigationController()
    mapCoordinator = MapCoordinator(navigationController: mapNavController)
    mapCoordinator?.start()
    let mapTabBarItem = UITabBarItem(title: "Map".localized, image: UIImage(named: "map"), tag: 0)
    mapTabBarItem.accessibilityLabel = "Map"
    mapNavController.tabBarItem = mapTabBarItem
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [mapNavController]
    tabBarController.tabBar.tintColor = .green
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    
    return true
  }
}
