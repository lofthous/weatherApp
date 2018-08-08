//
//  weatherModel.swift
//  WeatherApp
//
//  Created by Andrew Lofthouse on 07/08/2018.
//  Copyright © 2018 Andrew Lofthouse. All rights reserved.
//

import Foundation

struct coord : Codable{
    let lon : Float
    let lat : Float
}

struct main : Codable {
    let temp : Float
    let temp_min : Float
    let temp_max : Float
    let pressure : Float
    let sea_level : Float
    let grnd_level : Float
    let humidity : Int
    let temp_kf : Float
}

struct weather : Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}

struct clouds : Codable {
    let all : Int
}

struct wind : Codable {
    let speed : Float
    let deg : Float
}

struct sys :Codable {
    let pod : String
}

struct rain : Codable {
    
}

struct list : Codable {
    let dt : Int
    let main : main
    let weather : [weather]
    let clouds : clouds
    let wind : wind
    let rain : rain
    let sys : sys
    let dt_txt: String
}

struct city : Codable{
    let id: Int
    let name: String
    let coord: coord
    let country: String
}

struct weatherResponse : Codable {
    let cod : String
    let message : Float
    let cnt : Int
    let list : [list]
    let city : city
}
