//
//  ForecastWeatherResponse.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

struct ForecastWeatherResponse: Codable {
    let code: String
    let message: Int
    let count: Int
    let list: [ForecastWeather]
    let city: ForecastWeatherCity
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case list, city
    }
    
    static func emptyInit() -> ForecastWeatherResponse {
        return ForecastWeatherResponse(
            code: "",
            message: 0,
            count: 0,
            list: [],
            city: ForecastWeatherCity.emptyInit()
        )
    }
    
    var dailyList: [ForecastWeather] {
        var result: [ForecastWeather] = []
        guard var before = list.first else {
            return result
        }
        
        if before.date.dateFromMilliseconds().dayWord() != Date().dayWord() {
            result.append(before)
        }

        for weather in list {
            if weather.date.dateFromMilliseconds().dayWord() != before.date.dateFromMilliseconds().dayWord() {
                result.append(weather)
            }
            before = weather
        }

        return result
    }
    
    var byDaysList: ForecastWeatherByDays {
        
        var result = ForecastWeatherByDays.emptyInit()
        result.city = city.name
        
        guard var before = list.first else {
            return result
        }
        var forecastWeatherByDays = ForecastWeatherByDay.emptyInit()
        forecastWeatherByDays.dayOfWeek = "Today"

        for weather in list {
            
            if weather.date.dateFromMilliseconds().dayWord() == before.date.dateFromMilliseconds().dayWord() {
                forecastWeatherByDays.forecastWeather.append(weather)
            }
            else {
                result.weatherByDays.append(forecastWeatherByDays)
                before = weather
                forecastWeatherByDays = ForecastWeatherByDay.emptyInit()
                forecastWeatherByDays.forecastWeather.append(weather)
                forecastWeatherByDays.dayOfWeek = weather.date.dateFromMilliseconds().dayWord()
            }
        }
        result.weatherByDays.append(forecastWeatherByDays)

        return result
    }
    
}
