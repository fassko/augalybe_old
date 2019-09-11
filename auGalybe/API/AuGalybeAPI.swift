//
//  AuGalybeAPI.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 06/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import Foundation

struct AuGalybeAPI {
  
  private var dataURL: URL {
    guard CommandLine.arguments.contains("-localData") else {
      return URL(string: "https://box.tustinarvai.lt/tools/augalybe-app/api/restaurants")!
    }
    
    return Bundle.main.url(forResource: "restaurants", withExtension: "json")!
  }
  
  func restaurants(_ completion: @escaping (Result<[Restaurant], Error>) -> Void) {
    let request = URLRequest(url: dataURL, cachePolicy: .reloadIgnoringLocalCacheData)
    
    URLSession.shared.dataTask(with: request) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else {
        do {
          let decodedRestaurants = try JSONDecoder().decode(Restaurants.self, from: data!).restaurants
          let restaurants = decodedRestaurants.map { $0.restaurant }.filter {
            $0.latitude != nil && $0.longitude != nil
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
