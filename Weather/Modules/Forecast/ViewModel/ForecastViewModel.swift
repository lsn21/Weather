//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

final class ForecastViewModel: ObservableObject {
    
        // MARK: - Properties
        let client = APIClient()
        
        var stateView: StateView = StateView.loading {
            willSet {
                objectWillChange.send()
            }
        }

        var hourlyWeathers: [ForecastWeather] = [] {
            willSet {
                objectWillChange.send()
            }
        }

        var dailyWeathers: [ForecastWeather] = [] {
            willSet {
                objectWillChange.send()
            }
        }
        
        private var stateCurrentWeather = StateView.loading
        private var stateForecastWeather = StateView.loading

        init() {
            //getData()
        }
        
        func retry() {
            stateView = .loading
            stateForecastWeather = .loading
            
            getData()
        }
        
        private func getData() {
            
            client.getForecastWeather(at: Location.shared.getLocation()) { [weak self] forecastWeatherResponse, error in
                guard let ws = self else { return }
                if let forecastWeatherResponse = forecastWeatherResponse {
                    ws.hourlyWeathers = forecastWeatherResponse.list
                    ws.dailyWeathers = forecastWeatherResponse.dailyList
                    ws.stateForecastWeather = .success
                } else {
                    ws.stateForecastWeather = .failed
                }
                ws.updateStateView()
            }
        }
            
        private func updateStateView() {
            if stateCurrentWeather == .success, stateForecastWeather == .success {
                stateView = .success
            }
            
            if stateCurrentWeather == .failed, stateForecastWeather == .failed {
                stateView = .failed
            }
        }
        func viewDidLoad() {

            getData()
        }
    }
