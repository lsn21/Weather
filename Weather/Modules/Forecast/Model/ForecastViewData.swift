//
//  ForecastViewData.swift
//  Weather
//
//  Created by Siarhei on 10.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

enum ForecastViewData {
    case loading
    case success(ForecastWeatherByDays)
    case failed(Bool)
}
