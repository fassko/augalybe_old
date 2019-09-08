//
//  auGalybeAPI.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 06/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import Foundation

struct Restaurants: Decodable {
  let restaurants: [RestaurantWrapper]
}

struct RestaurantWrapper: Decodable {
  let restaurant: Restaurant
}

struct Picture: Codable {
  let src: String
  let alt: String
}

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
  
  var longitue: Double? {
    guard let last = coordinateParts.last else {
      return nil
    }
    
    return Double(last)
  }
  
  private var coordinateParts: [String] {
    Array(coordinates.split(separator: ",")).map { String($0) }
  }
}

struct auGalybeAPI {
  func restaurants(_ completion: @escaping (Result<[Restaurant], Error>) -> Void) {
    
    let url = URL(string: "https://box.tustinarvai.lt/tools/augalybe-app/api/restaurants")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
    
    URLSession.shared.dataTask(with: request) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else {
        do {
          let restaurants = try JSONDecoder().decode(Restaurants.self, from: data!).restaurants.compactMap{ restaurant -> Restaurant? in
            guard restaurant.restaurant.longitue == nil || restaurant.restaurant.latitude == nil else {
              return nil
            }
            
            return restaurant.restaurant
          }
          
          DispatchQueue.main.async {
            completion(.success(restaurants))
          }
        } catch {
          completion(.failure(error))
        }
      }
    }.resume()
  }
}
