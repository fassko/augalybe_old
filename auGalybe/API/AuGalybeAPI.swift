//
//  AuGalybeAPI.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 06/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import Foundation

struct AuGalybeAPI {
  func restaurants(_ completion: @escaping (Result<[Restaurant], Error>) -> Void) {
    
    let url = URL(string: "https://box.tustinarvai.lt/tools/augalybe-app/api/restaurants")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
    
    URLSession.shared.dataTask(with: request) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else {
        do {
          let decodedRestaurants = try JSONDecoder().decode(Restaurants.self, from: data!).restaurants
          let restaurants = decodedRestaurants.compactMap { restaurant -> Restaurant? in
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
