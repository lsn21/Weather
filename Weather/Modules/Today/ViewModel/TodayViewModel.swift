//
//  TodayViewModel.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

protocol TodayViewModelProtocol {
    var updateViewData: ((TodayViewData)->())? { get set }
}

final class TodayViewModel: TodayViewModelProtocol {
    
    var updateViewData: ((TodayViewData) -> ())?
    let client = APIClient()
    
    var stateView: StateView = StateView.loading
    var currentWeather = CurrentWeather.emptyInit()
    
    private var stateCurrentWeather = StateView.loading

    init() {
        getData()
    }
    
    private func getData() {
        
        if stateCurrentWeather == .loading {
            updateViewData?(.loading)
        }
        client.getCurrentWeather(at: Location.shared.getLocation()) { [weak self] currentWeather, error in
            guard let ws = self else { return }
            if let currentWeather = currentWeather {
                ws.currentWeather = currentWeather
                ws.stateCurrentWeather = .success
            } else {
                ws.stateCurrentWeather = .failed
            }
            ws.updateStateView()
        }
    }
        
    private func updateStateView() {
        if stateCurrentWeather == .success {
            stateView = .success
            updateViewData?(.success(currentWeather))
        }
        
        if stateCurrentWeather == .failed {
            stateView = .failed
        }
    }
}
