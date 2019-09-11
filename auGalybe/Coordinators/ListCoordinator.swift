//
//  ListCoordinator.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 11/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

class ListCoordinator: Coordinator {
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
   let listTableViewController = ListTableViewController.instantiate()
     listTableViewController.coordinator = self
     navigationController.pushViewController(listTableViewController, animated: false)
   }
   
   func show(_ restaurant: Restaurant) {
     let restaurantViewController = RestaurantViewController.instantiate()
     restaurantViewController.restaurant = restaurant
     navigationController.pushViewController(restaurantViewController, animated: true)
   }
}
