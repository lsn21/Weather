//
//  ForecastWeatherByDays.swift
//  Weather
//
//  Created by Siarhei on 10.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

struct ForecastWeatherByDay {
    
    var dayOfWeek: String
    var forecastWeather: [ForecastWeather]
    
    static func emptyInit() -> ForecastWeatherByDay {
        return ForecastWeatherByDay(
            dayOfWeek: "",
            forecastWeather: []
        )
    }
}

struct ForecastWeatherByDays {
    var city: String
    var weatherByDays: [ForecastWeatherByDay]
        
    static func emptyInit() -> ForecastWeatherByDays {
        return ForecastWeatherByDays(
            city: "",
            weatherByDays: []
        )
    }
}
