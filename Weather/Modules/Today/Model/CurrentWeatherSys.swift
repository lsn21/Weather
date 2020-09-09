//
//  CurrentWeatherSys.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

struct CurrentWeatherSys: Codable {
    let id: Int?
    let type: Int?
    let country: String
    let sunrise: Int
    let sunset: Int

    static func emptyInit() -> CurrentWeatherSys {
        return CurrentWeatherSys(
            id: 0,
            type: 0,
            country: "",
            sunrise: 0,
            sunset: 0
        )
    }
}
