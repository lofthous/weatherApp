//
//  WeatherLogic.swift
//  WeatherApp
//
//  Created by Andrew Lofthouse on 07/08/2018.
//  Copyright © 2018 Andrew Lofthouse. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherLogic {
    let weatherService = WeatherService()
    let unitHelper = unitHelpers()
    func getWeatherUpdate(location: CLLocation, completion: @escaping (weatherWeek?, Error?) -> ()) {
        weatherService.getWeatherForLocation(location: location) { (weather, error) in
            if error == nil {
                guard let weatherData = weather else {return}
                var weatherArray = weatherWeek(weatherDays: [])
                for weatherEntry in weatherData.list {
                    let date = Date(timeIntervalSince1970: TimeInterval(weatherEntry.dt))
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                    let weatherDayVar = weatherDay(
                        max_temp: String(format: "%.1f°C", self.unitHelper.kelvinToCelcius(temp: weatherEntry.main.temp_min)),
                        min_temp: String(format: "%.1f°C",self.unitHelper.kelvinToCelcius(temp: weatherEntry.main.temp_min)),
                        temp: String(format: "%.1f°C",self.unitHelper.kelvinToCelcius(temp: weatherEntry.main.temp_max)),
                        title: weatherEntry.weather.first?.main ?? "" ,
                        description: weatherEntry.weather.first?.description ?? "",
                        date: dateFormatter.string(from: date))

                    weatherArray.weatherDays.append(weatherDayVar)
                }
                completion(weatherArray, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
