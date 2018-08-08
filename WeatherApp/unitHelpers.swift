//
//  unitHelpers.swift
//  WeatherApp
//
//  Created by Andrew Lofthouse on 06/08/2018.
//  Copyright © 2018 Andrew Lofthouse. All rights reserved.
//

import Foundation

class unitHelpers {
    
    // function to convert kelvin to Celsius
    public func kelvinToCelcius(temp : Float) -> Float {
        
        return temp - 273.15
    }
    
    // function to convert kelvin to Fahrenheit
    public func kelvinToFahrenheit(temp : Float) -> Float {
        
        return temp * (9/5) - 459.67
    }
    
}
