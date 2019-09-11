//
//  AboutCoordinator.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 11/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

class AboutCoordinator: Coordinator {
var navigationController: UINavigationController

init(navigationController: UINavigationController) {
  self.navigationController = navigationController
}

func start() {
 let aboutViewController = AboutViewController.instantiate()
   aboutViewController.coordinator = self
   navigationController.pushViewController(aboutViewController, animated: false)
 }
}
