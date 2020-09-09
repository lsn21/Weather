//
//  Coordinate.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

struct Coordinate: Codable {
    var lon: Double
    var lat: Double

    static func emptyInit() -> Coordinate {
        return Coordinate(lon: 0, lat: 0)
    }
}
