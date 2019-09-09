//
//  Coordinator.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 08/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

protocol Coordinator {
  
  var navigationController: UINavigationController { get set }
  
  func start()
}
