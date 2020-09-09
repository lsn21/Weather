//
//  CurrentWeather.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    let timezone: Int
    let id: Int
    let name: String
    let coordinate: Coordinate
    let elements: [WeatherElement]
    let base: String
    let mainValue: CurrentWeatherMainValue
    let visibility: Int
    let wind: WeatherWind
    let clouds: WeatherClouds
    let date: Int
    let sys: CurrentWeatherSys
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case timezone
        case id
        case name
        case coordinate = "coord"
        case base
        case mainValue = "main"
        case visibility
        case wind
        case clouds
        case date = "dt"
        case sys
        case elements = "weather"
        case code = "cod"
    }
    
    static func emptyInit() -> CurrentWeather {
        return CurrentWeather(
            timezone: 0,
            id: 0,
            name: "",
            coordinate: Coordinate.emptyInit(),
            elements: [],
            base: "",
            mainValue: CurrentWeatherMainValue.emptyInit(),
            visibility: 0,
            wind: WeatherWind.emptyInit(),
            clouds: WeatherClouds.emptyInit(),
            date: 0,
            sys: CurrentWeatherSys.emptyInit(),
            code: 0
        )
    }
    
    func description() -> String {
        var result = "Today: "
        if let weatherElement = elements.first {
            result += "\(weatherElement.weatherDescription.capitalizingFirstLetter()) currently. "
        }
        result += "It's \(mainValue.temp)°."
        return result
    }
    
    func getForecastWeather() -> ForecastWeather {
        var result = ForecastWeather.emptyInit()

        result.date = self.date
        result.mainValue.tempMin = self.mainValue.tempMin
        result.mainValue.tempMax = self.mainValue.tempMax

        if let weatherElement = elements.first {
            result.elements.append(weatherElement)
        }

        return result
    }
}
