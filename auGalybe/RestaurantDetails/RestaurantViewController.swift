//
//  RestaurantViewController.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 11/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

import Kingfisher

class RestaurantViewController: UIViewController, Storyboarded {
  
  var restaurant: Restaurant!
  
  @IBOutlet weak var addressButton: UIButton!
  @IBOutlet weak var picture: UIImageView!
  @IBOutlet weak var navigateButton: UIButton!
  
  private var latitude: Double {
    restaurant.latitude!
  }
  
  private var longitude: Double {
    restaurant.longitude!
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
    title = restaurant.title
    adjustLargeTitleSize()
    
    addressButton.setTitle(restaurant.address)
    
    picture.kf.indicatorType = .activity
    if let pictureURL = URL(string: restaurant.picture.src) {
      picture.kf.setImage(with: pictureURL)
    }
  }
  
  @IBAction func copyAddress(_ sender: Any) {
    copyAddress()
  }
  
  private func copyAddress() {
    UIPasteboard.general.copy(restaurant.address)
  }
  
  @IBAction func navigate(_ sender: Any) {
    let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let copyAddress = UIAlertAction(title: "Copy Address".localized, style: .default) { _ in
      self.copyAddress()
    }
    
    let copyAction = UIAlertAction(title: "Copy Coordiantes".localized, style: .default) { _ in
      UIPasteboard.general.copy("\(String(format: "%.5f", self.latitude)), \(String(format: "%.5f", self.longitude))")
    }
    
    let appleMapsAction = UIAlertAction(title: "Apple Maps", style: .default) {_ in
        let daddr = "\(self.latitude),\(self.longitude)"
        self.open("http://maps.apple.com/?daddr=\(daddr)")
    }
    
    let googleMapsAction = UIAlertAction(title: "Google Maps", style: .default) { _ in
      if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
        self.open("comgooglemaps://?saddr=&daddr=\(self.latitude),\(self.longitude)&directionsmode=driving")
      } else {
        self.open("http://itunes.apple.com/lv/app/id585027354")
      }
    }
    
    let wazeAction = UIAlertAction(title: "Waze", style: .default) { _ in
      if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
        self.open("waze://?ll=\(self.latitude),\(self.longitude)&navigate=yes")
      } else {
        self.open("http://itunes.apple.com/lv/app/id323229106")
      }
    }
    
    let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
    
    optionMenu.addAction(copyAddress)
    optionMenu.addAction(copyAction)
    optionMenu.addAction(appleMapsAction)
    optionMenu.addAction(googleMapsAction)
    optionMenu.addAction(wazeAction)
    optionMenu.addAction(cancelAction)
    
    present(optionMenu, animated: true, completion: nil)
  }
}

extension RestaurantViewController {
  func adjustLargeTitleSize() {
    guard let title = title else {
      return
    }
    
    let maxWidth = UIScreen.main.bounds.size.width - 60
    var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
    var width = title.size(withAttributes: [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
      NSAttributedString.Key.foregroundColor: UIColor.green
    ]).width
    
    while width > maxWidth {
      fontSize -= 1
      width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
    }
    
    navigationController?.navigationBar.largeTitleTextAttributes = [
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize),
      NSAttributedString.Key.foregroundColor: UIColor.green
    ]
  }
}
