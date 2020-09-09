//
//  ForecastWeatherMainValue.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

struct ForecastWeatherMainValue: Codable {
    let temp: Double
    let feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    let pressure: Int
    let seaLevel: Int
    let grndLevel: Int
    let humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    static func emptyInit() -> ForecastWeatherMainValue {
        return ForecastWeatherMainValue(
            temp: 0.0,
            feelsLike: 0.0,
            tempMin: 0.0,
            tempMax: 0.9,
            pressure: 0,
            seaLevel: 0,
            grndLevel: 0,
            humidity: 0,
            tempKf: 0
        )
    }
}
