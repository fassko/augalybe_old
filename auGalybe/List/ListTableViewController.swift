//
//  ListTableViewController.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 11/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, Storyboarded {
  
  var coordinator: ListCoordinator!
  
  var restaurants = [Restaurant]()
  
  var filteredRestaurants = [Restaurant]()
  
  let searchController = UISearchController(searchResultsController: nil)
  
  var restaurantCount: Int {
    if isFiltering {
      return filteredRestaurants.count
    }
    
    return restaurants.count
  }
  
  private func restaurantFromList(with indexPath: IndexPath) -> Restaurant {
    let restaurant: Restaurant
    
    if isFiltering {
      restaurant = filteredRestaurants[indexPath.row]
    } else {
      restaurant = restaurants[indexPath.row]
    }

    return restaurant
  }
  
  @objc fileprivate func loadData() {
    let auGalybeAPI = AuGalybeAPI()
    auGalybeAPI.restaurants {[weak self] result in
      switch result {
      case .failure(let error):
        print("Failed to load restaurants \(error)")
      case .success(let restaurants):
        self?.restaurants = restaurants
        self?.tableView.reloadData()
        self?.tableView.refreshControl?.endRefreshing()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "List".localized
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.largeTitleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.green
    ]
    
    loadData()
    
    tableView.refreshControl = {() -> UIRefreshControl in
      let refreshControl = UIRefreshControl()
      refreshControl.addTarget(self, action:
        #selector(loadData),
                               for: UIControl.Event.valueChanged)
      refreshControl.tintColor = .green
      
      return refreshControl
    }()
    
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Places".localized
    searchController.searchBar.accessibilityIdentifier = "Search"
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
  
  @IBAction func refresh(_ sender: Any) {
    loadData()
  }
}

extension ListTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurantCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath)
    
    let restaurant = restaurantFromList(with: indexPath)
    cell.textLabel?.text = restaurant.title
    cell.detailTextLabel?.text = restaurant.address
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let restaurant = restaurants[indexPath.row]
    coordinator.show(restaurant)
  }
}

extension ListTableViewController: UISearchResultsUpdating {
  
  private var searchBarIsEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  private var isFiltering: Bool {
    return searchController.isActive && !searchBarIsEmpty
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
  func filterContentForSearchText(_ searchText: String) {
    
    let searchText = searchText.lowercased()
    
    filteredRestaurants = restaurants.filter { restaurant in
      return restaurant.title.lowercased().contains(searchText)
        || restaurant.address.lowercased().contains(searchText)
        || restaurant.description.lowercased().contains(searchText)
    }
    
    tableView.reloadData()
  }
}
