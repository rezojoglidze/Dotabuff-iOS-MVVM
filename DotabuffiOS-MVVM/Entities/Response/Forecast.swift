//
//  Forecast.swift
//  WeatheriOS
//
//  Created by Rezo Joglidze on 9/15/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let cod: String
    let message,cnt: Int
    let list: [List]
    let city: City
}



struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise, sunset: Int
}

struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let dt_txt: String
}
