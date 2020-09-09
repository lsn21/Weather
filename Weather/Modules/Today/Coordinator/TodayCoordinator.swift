//
//  TodayCoordinator.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

final class TodayCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Coordinator
    
    func start() {
        showTodayViewController()
    }
    
    private func showTodayViewController() {
        let viewController = screens.createTodayViewController()
        presenter.viewControllers = [viewController]
    }
}
