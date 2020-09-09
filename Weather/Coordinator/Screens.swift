//
//  Screens.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

final class Screens {
    
    // MARK: - Properties
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
}

// MARK: - TodayViewController

extension Screens {
    func createTodayViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "TodayViewController") as! TodayViewController
        let viewModel = TodayViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - ForecastViewController

extension Screens {
    func createForecastViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(identifier: "ForecastViewController") as! ForecastViewController
        let viewModel = ForecastViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}
