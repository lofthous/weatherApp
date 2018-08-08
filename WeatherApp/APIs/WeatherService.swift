//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Andrew Lofthouse on 07/08/2018.
//  Copyright © 2018 Andrew Lofthouse. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherService {

    let apiKey = "b060ca0d700233d916a484f97335a642"
    func getWeatherForLocation(location: CLLocation, completion: @escaping (weatherResponse?, Error?) -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat="+String(location.coordinate.latitude)+"&lon="+String(location.coordinate.longitude) + "&APPID=" + apiKey
        //let urlString = "https://samples.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22"
        guard let weatherURL = URL(string: urlString) else { return }
        let defaultSession = URLSession(configuration: .default)
        defaultSession.dataTask(with: weatherURL) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(weatherResponse.self, from: data)
                completion(weatherData, nil)
            } catch let err {
                completion(nil,err)
            }
        }.resume()
    }
}
