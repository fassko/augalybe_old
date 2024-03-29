//
//  auGalybeTests.swift
//  auGalybeTests
//
//  Created by Kristaps Grinbergs on 08/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import XCTest

@testable import auGalybe

class AuGalybeTests: XCTestCase {
  func testCoordintesCoorect() {
    let restaurant = Restaurant(title: "",
                                address: "",
                                city: "",
                                coordinates: "54.694728, 25.287477",
                                description: "",
                                picture: Picture(src: "", alt: ""),
                                pictures: [],
                                facebook: "",
                                website: "")
    XCTAssertEqual(restaurant.latitude, 54.694728)
    XCTAssertEqual(restaurant.longitude, 25.287477)
  }
  
  func testCoordinatesWrong() {
    let restaurant = Restaurant(title: "",
                                address: "",
                                city: "",
                                coordinates: "Test test",
                                description: "",
                                picture: Picture(src: "", alt: ""),
                                pictures: [],
                                facebook: "",
                                website: "")
    XCTAssertNil(restaurant.latitude)
    XCTAssertNil(restaurant.longitude)
  }
  
  func testLoadData() {
    let loadDataExectation = expectation(description: "dataLoadExpectation")
    
    let api = AuGalybeAPI()
    api.restaurants { result in
      switch result {
      case .success(let data):
        XCTAssertNotNil(data)
        loadDataExectation.fulfill()
      case .failure(let error):
        XCTFail("Failed to load data \(error.localizedDescription)")
      }
    }
    
    wait(for: [loadDataExectation], timeout: 3.0)
  }
  
}
