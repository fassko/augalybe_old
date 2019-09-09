//
//  RestaurantAnnotation.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 09/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import Foundation
import MapKit

class RestaurantAnnotation: MKPointAnnotation, UIAccessibilityIdentification {
  var accessibilityIdentifier: String?
  
  let restaurant: Restaurant
  
  init(_ restaurant: Restaurant) {
    self.restaurant = restaurant
    
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
