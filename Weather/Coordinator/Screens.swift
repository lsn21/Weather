//
//  Screens.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

final class Screens {
    
    func createTodayViewController() -> UIViewController {
        let viewController = TodayViewController()
        let viewModel = TodayViewModel()
        viewController.viewModel = viewModel
        viewController.view.backgroundColor = .white
        return viewController
    }

    func createForecastViewController() -> UIViewController {
        let viewController = ForecastViewController()
        let viewModel = ForecastViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}
