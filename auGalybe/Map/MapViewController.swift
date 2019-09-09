//
//  MapViewController.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 09/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var mapView: MKMapView!
  
  var coordinator: MapCoordinator!
  
  private var restaurants: [Restaurant]?
  
  private let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Map".localized
    
    navigationItem.largeTitleDisplayMode = .never
    
    if CLLocationManager.authorizationStatus() == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
    setupMap()
    loadData()
  }
  
  @IBAction func refresh(_ sender: Any) {
    loadData()
  }
  
  private func setupMap() {
    let centerCoordinate = CLLocationCoordinate2D(latitude: 55.3299167, longitude: 23.9058611)
    let region = MKCoordinateRegion(center: centerCoordinate,
                                    latitudinalMeters: 300000,
                                    longitudinalMeters: 300000)
    mapView.setRegion(region, animated: false)
    mapView.showsCompass = true
    mapView.showsScale = true
  }
  
  private func loadData() {
    let auGalybeAPI = AuGalybeAPI()
    auGalybeAPI.restaurants {[weak self] result in
      switch result {
      case .success(let restaurants):
        self?.restaurants = restaurants
        
        let annotations = restaurants.map { restaurant -> RestaurantAnnotation in
          let annotation = RestaurantAnnotation(restaurant)
          annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude!,
                                                         longitude: restaurant.longitude!)
          annotation.title = restaurant.title
          annotation.subtitle = restaurant.address
          annotation.accessibilityLabel = restaurant.title
          annotation.accessibilityIdentifier = restaurant.title
          return annotation
        }

        self?.clearMapData()
        self?.mapView.addAnnotations(annotations)
      case .failure(let error):
        print("Failed to load restaurants \(error)")
      }
    }
  }
  
  private func clearMapData() {
    mapView.removeAnnotations(mapView.annotations)
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    if let userLocationView = mapView.view(for: mapView.userLocation) {
      userLocationView.canShowCallout = false
    }
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? RestaurantAnnotation else {
      return nil
    }
    
    let identifier = "marker"
    var view: MKAnnotationView
    
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      view.image = UIImage(named: "pin")
      view.displayPriority = .required
      view.rightCalloutAccessoryView?.tintColor = .green
    }

    return view
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    guard let storeAnnotation = view.annotation as? RestaurantAnnotation else {
      return
    }
    
//    coordinator.show(storeAnnotation.place)
    mapView.deselectAnnotation(view.annotation, animated: true)
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    for view in view.subviews where view.subviews.count > 0 {
      let colloutView = view.subviews[0]
      if colloutView.subviews.count > 0 {
        if colloutView.subviews[0].subviews.count > 0 {
          colloutView.subviews[0].subviews.forEach { view in
            if let label = view as? UILabel {
              label.textColor = .grey
            }
          }
        }
      }
    }
  }
}
