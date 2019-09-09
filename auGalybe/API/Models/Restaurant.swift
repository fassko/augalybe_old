//
//  Restaurant.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 08/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
  let title: String
  let address: String
  let city: String
  let coordinates: String
  let description: String
  let picture: Picture
  let pictures: [Picture]
  let facebook: String
  let website: String
  
  enum CodingKeys: String, CodingKey {
    case title
    case address = "Address"
    case city = "City"
    case coordinates = "Coordinates"
    case description = "Description"
    case pictures = "Picture"
    case picture = "Main Picture"
    case facebook = "Facebook link"
    case website = "Website"
  }
  
  var latitude: Double? {
    guard let first = coordinateParts.first else {
      return nil
    }
    
    return Double(first)
  }
  
  var longitude: Double? {
    guard let last = coordinateParts.last else {
      return nil
    }
    
    return Double(last)
  }
  
  private var coordinateParts: [String] {
    Array(coordinates.split(separator: ",")).map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
  }
}
