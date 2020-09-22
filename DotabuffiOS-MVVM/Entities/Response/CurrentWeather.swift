//
//  currentWeather.swift
//  WeatheriOS
//
//  Created by Rezo Joglidze on 9/14/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    let base,name: String
    let clouds: Clouds
    let coord: Coord
    let dt,id,cod: Int
    let main: Main
    let sys: Sys
    let timezone, visibility: Int
    let weather: [Weather]
    let wind: Wind
}

struct Clouds: Codable {
    let all: Int
}

struct Coord: Codable {
    let lat,lon: Double
}

struct Main: Codable {
    let feels_like: Double
    let humidity: Double
    let pressure: Double
    let temp: Double
    let temp_max: Double
    let temp_min: Double
}

struct Sys: Codable {
    let country: String
    let id: Int
    let sunrise,sunset: Int
    let type: Int
}


struct Weather: Codable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}

struct Wind: Codable {
    let deg: Int
    let speed: Double
}
