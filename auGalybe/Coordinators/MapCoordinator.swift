//
//  MapCoordinator.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 09/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

class MapCoordinator: Coordinator {
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let mapViewController = MapViewController.instantiate()
    mapViewController.coordinator = self
    navigationController.pushViewController(mapViewController, animated: false)
  }
  
  func show(_ restaurant: Restaurant) {
    let restaurantViewController = RestaurantViewController.instantiate()
    restaurantViewController.restaurant = restaurant
    navigationController.pushViewController(restaurantViewController, animated: true)
  }
}
