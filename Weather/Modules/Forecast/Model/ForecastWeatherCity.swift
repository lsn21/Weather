//
//  ForecastWeatherCity.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

struct ForecastWeatherCity: Codable {
    let id: Int
    let name: String
    let coordinate: Coordinate
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinate = "coord"
        case country
        case timezone
        case sunrise
        case sunset
    }
    
    static func emptyInit() -> ForecastWeatherCity {
        return ForecastWeatherCity(
            id: 0,
            name: "",
            coordinate: Coordinate.emptyInit(),
            country: "",
            timezone: 0,
            sunrise: 0,
            sunset: 0
        )
    }
}
