//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

protocol ForecastViewModelProtocol {
    var updateViewData: ((ForecastViewData)->())? { get set }
}

final class ForecastViewModel: ForecastViewModelProtocol {
    
    var updateViewData: ((ForecastViewData) -> ())?
    let client = APIClient()
    
    var forecastWeatherByDays: ForecastWeatherByDays?

    private var stateForecastWeather = StateView.loading

    init() {
        getData()
    }
    
    private func getData() {
        
        client.getForecastWeather(at: Location.shared.getLocation()) { [weak self] forecastWeatherResponse, error in
            guard let ws = self else { return }
            if let forecastWeatherResponse = forecastWeatherResponse {
                ws.forecastWeatherByDays = forecastWeatherResponse.byDaysList
                ws.stateForecastWeather = .success
            }
            else {
                if Reachability.isConnectedToNetwork(){
                    ws.stateForecastWeather = .failed
                }
                else{
                    ws.stateForecastWeather = .noInternet
                }
            }
            ws.updateStateView()
        }
    }
        
    private func updateStateView() {
        if stateForecastWeather == .success {
            updateViewData?(.success(forecastWeatherByDays ?? ForecastWeatherByDays.emptyInit()))
        }
        if stateForecastWeather == .failed {
            updateViewData?(.failed(true))
        }
        if stateForecastWeather == .noInternet {
            updateViewData?(.failed(false))
        }
    }
}
