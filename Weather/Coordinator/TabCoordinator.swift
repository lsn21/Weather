//
//  TabCoordinator.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

// Name of the coordinators/stacks
enum ViewControllerItem: Int {
    case first = 0
    case second = 1
}

protocol TabBarSourceType {
    var items: [UINavigationController] {get set}
}

final class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]
    
    // Initialise the TabBar items with name and Icons
    init() {
        let firstIcon = UIImage(systemName: "1.circle")
        let filledTodayIcon = UIImage(systemName: "1.circle.fill")
        self[.first].tabBarItem = UITabBarItem(title: "Today", image: firstIcon, selectedImage: filledTodayIcon)
        let secondIcon = UIImage(systemName: "2.circle")
        let filledForecastIcon = UIImage(systemName: "2.circle.fill")
        self[.second].tabBarItem = UITabBarItem(title: "Forecast", image: secondIcon, selectedImage: filledForecastIcon)
    }
}

// transform the index of the item in "items" into a case of the enum ViewControllerItem
extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exist")
            }
            return items[item.rawValue]
        }
    }
}

final class TabCoordinator: NSObject {
    
    // MARK: - Properties
    
    private let presenter: UIWindow
    
    private let tabBarController: UITabBarController
    
    private let screens: Screens
    
    private var firstCoordinator: TodayCoordinator?
    
    private var secondCoordinator: ForecastCoordinator?
    
    private var source: TabBarSource = TabBarSource()
    
    // MARK: - Initializer
    
    init(presenter: UIWindow) {
        self.presenter = presenter
        
        self.screens = Screens()
        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = source.items
        tabBarController.selectedViewController = source[.first]
        super.init()
        
        tabBarController.delegate = self
    }
    
    func start() {
        presenter.rootViewController = tabBarController
        showTodayTab()
    }
    
    private func showTodayTab() {
        firstCoordinator = TodayCoordinator(presenter: source[.first], screens: screens)
        firstCoordinator?.start()
    }
    
    private func showForecastTab() {
        secondCoordinator = ForecastCoordinator(presenter: source[.second], screens: screens)
        secondCoordinator?.start()
    }
}

// get the rawvalue of the selected item, and call the relative func show()
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < source.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Index out of range")
        }
        
        switch item {
        case .first:
            showTodayTab()
        case .second:
            showForecastTab()
        }
    }
}
