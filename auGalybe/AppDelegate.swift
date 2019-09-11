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
  var listCoordinator: ListCoordinator?
  var aboutCoordinator: AboutCoordinator?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let mapNavController = AuGalybeNavigationController()
    mapCoordinator = MapCoordinator(navigationController: mapNavController)
    mapCoordinator?.start()
    let mapTabBarItem = UITabBarItem(title: "Map".localized, image: UIImage(named: "map"), tag: 0)
    mapTabBarItem.accessibilityLabel = "Map"
    mapNavController.tabBarItem = mapTabBarItem
    
    let listNavController = AuGalybeNavigationController()
    listCoordinator = ListCoordinator(navigationController: listNavController)
    listCoordinator?.start()
    let listTabBarItem = UITabBarItem(title: "List".localized, image: UIImage(named: "list"), tag: 1)
    mapTabBarItem.accessibilityLabel = "List"
    listNavController.tabBarItem = listTabBarItem
    
    let aboutNavController = AuGalybeNavigationController()
    aboutCoordinator = AboutCoordinator(navigationController: aboutNavController)
    aboutCoordinator?.start()
    let aboutTabBarItem = UITabBarItem(title: "About".localized, image: UIImage(named: "about"), tag: 2)
    aboutTabBarItem.accessibilityLabel = "List"
    aboutNavController.tabBarItem = aboutTabBarItem
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [mapNavController, listNavController, aboutNavController]
    tabBarController.tabBar.tintColor = .green
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    
    return true
  }
}
