//
//  ForecastView.swift
//  Weather
//
//  Created by Siarhei on 10.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

class ForecastView: UIView {
    
    var viewData: ForecastViewData = .loading {
        didSet {
            setNeedsLayout()
        }
    }

    var tableView = UITableView(frame: .zero, style: .plain)
    var forecastWeatherByDays: ForecastWeatherByDays?
    
    lazy var activityIndicator = makeActivityIndicatorView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .loading:
            update(viewData: nil, isHidden: false)
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .success(let success):
            update(viewData: success, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .failure(let failure):
            update(viewData: failure, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    private func update(viewData: ForecastWeatherByDays?, isHidden: Bool) {
        
        forecastWeatherByDays = viewData
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
    
}
