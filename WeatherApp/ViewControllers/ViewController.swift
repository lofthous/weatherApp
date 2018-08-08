//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrew Lofthouse on 06/08/2018.
//  Copyright © 2018 Andrew Lofthouse. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    enum UIStates {
        case searching
        case weather
    }
    static let maxAge:Double = 100
    var locationManager = CLLocationManager()
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var weatherLocation = CLLocation()
    let weatherService = WeatherLogic()
    var uiState:UIStates = .weather
    var weeksWeather : weatherWeek = weatherWeek(weatherDays: [])
    

    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var currentLocationButton : UIButton!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
        locationManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeUIState (state : UIStates) {
        uiState = state
        switch state {
        case .searching:
            searchResultsTableView.isHidden = false
            searchResultsTableView.reloadData()
            UIView.animate(withDuration: 0.7) {
                self.tableViewTopConstraint.constant = 60
                self.currentLocationButton.alpha = 1
                self.view.layoutSubviews()
            }
        case .weather:
           searchResultsTableView.isHidden = false
           searchBar.endEditing(true)
           self.startSearch()
           
            
        }
    }
    
    @IBAction func useCurrentLocation(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func startSearch() {
        weatherService.getWeatherUpdate(location: weatherLocation) { (weather, error) in
            if error == nil {
                guard let weatherData = weather else {return}
                DispatchQueue.main.async(execute: {
                    self.weeksWeather = weatherData
                    if weatherData.weatherDays.count > 0 {
                        UIView.animate(withDuration: 0.7, animations: {
                            self.tableViewTopConstraint.constant = 0
                            self.currentLocationButton.alpha = 0
                            self.view.layoutSubviews()
                        }) { (_) in
                            self.searchResultsTableView.reloadData()
                        }
                        
                    }
                }) 
            }
        }
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        changeUIState(state: .searching)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
    }
}

extension ViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if uiState == .searching {
            return 44
        } else {
            return 122
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if uiState == .searching {
            return searchResults.count
        } else {
            return weeksWeather.weatherDays.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if uiState == .searching {
            let searchResult = searchResults[indexPath.row]
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = searchResult.title
            cell.detailTextLabel?.text = searchResult.subtitle
            return cell
        } else {
            let cellsWeather = weeksWeather.weatherDays[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableViewCell", for: indexPath) as! weatherTableViewCell
            
            cell.titleLabel.text = cellsWeather.title
            cell.descriptionLabel.text = cellsWeather.description
            cell.tempLabel.text = cellsWeather.temp
            cell.maxTempLabel.text = cellsWeather.max_temp
            cell.minTempLabel.text = cellsWeather.min_temp
            cell.dateLabel.text = cellsWeather.date
            
            return cell
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {return}
            self.weatherLocation = CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
            guard let placename = response?.mapItems[0].placemark.locality else {return}
            self.searchBar.text = placename
            self.changeUIState(state: .weather)
        }
        
        
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if Date().timeIntervalSince(location.timestamp) <  ViewController.maxAge {
            locationManager.stopUpdatingLocation()
            let geocoder = CLGeocoder()
            weatherLocation = location
            geocoder.reverseGeocodeLocation(location) { (placemark, error) in
                if error == nil {
                    guard let placemark = placemark?.first else { return }
                    self.searchBar.text = placemark.locality
                }
            }
            changeUIState(state: .weather)
        }
    }
}



