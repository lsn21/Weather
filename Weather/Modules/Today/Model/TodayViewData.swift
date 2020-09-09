//
//  TodayViewData.swift
//  Weather
//
//  Created by Siarhei on 09.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

enum TodayViewData {
    case loading
    case success(CurrentWeather)
    case failure(CurrentWeather)
}
