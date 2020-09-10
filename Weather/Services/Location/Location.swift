//
//  Location.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit
import CoreLocation

class Location: CLLocationManager, CLLocationManagerDelegate {
    
    static let shared = Location()
    var locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()

    override init() {
        super.init()

        if (CLLocationManager.locationServicesEnabled()) {
            
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func getLocation() -> Coordinate {
        
        var coordinate = Coordinate.emptyInit()
        if let location = location {
            coordinate.lat = location.coordinate.latitude
            coordinate.lon = location.coordinate.longitude
        }
        return coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            //manager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            manager.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
}
