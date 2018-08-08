//
//  WeatherUIModel.swift
//  WeatherApp
//
//  Created by Andrew Lofthouse on 07/08/2018.
//  Copyright © 2018 Andrew Lofthouse. All rights reserved.
//

import Foundation

struct weatherDay {
    var max_temp : String
    var min_temp : String
    var temp : String
    var title : String
    var description : String
    var date : String
}

struct weatherWeek {
    var weatherDays : [weatherDay]
}
