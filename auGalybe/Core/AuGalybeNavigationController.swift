//
//  AuGalybeNavigationController.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 08/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

class AuGalybeNavigationController: UINavigationController {
  
  override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
//    navigationBar.tintColor = .pink
//    navigationBar.titleTextAttributes = [
//      NSAttributedString.Key.foregroundColor: UIColor.pink
//    ]
//    navigationBar.largeTitleTextAttributes = [
//      NSAttributedString.Key.foregroundColor: UIColor.pink
//    ]
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
