//
//  Storyboarded.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 08/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

protocol Storyboarded {
  static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
  static func instantiate() -> Self {
    let fullName = NSStringFromClass(self)
    let className = fullName.components(separatedBy: ".")[1]
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    //swiftlint:disable force_cast
    return storyboard.instantiateViewController(withIdentifier: className) as! Self
  }
}
