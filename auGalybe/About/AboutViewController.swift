//
//  AboutViewController.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 11/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, Storyboarded {
  
  var coordinator: AboutCoordinator!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "About".localized
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
