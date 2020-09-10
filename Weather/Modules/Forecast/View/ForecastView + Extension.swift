//
//  ForecastView + Extension.swift
//  Weather
//
//  Created by Siarhei on 10.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

extension ForecastView {
    
    func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .blue
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.center)
        }
        return activityIndicator
    }

    func headerView(_ name: String) -> UIView {
        
        let viewHeader = UIView()
        viewHeader.backgroundColor = UIColor(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1)
        
        let titleLabel = UILabel()
        titleLabel.text = name
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20)

        viewHeader.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(viewHeader).offset(8)
            make.left.equalTo(viewHeader).offset(16)
            make.right.equalTo(viewHeader).offset(16)
            make.bottom.equalTo(viewHeader).offset(-8)
            make.height.equalTo(40)
        }
        
        return viewHeader
    }
}

extension ForecastView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayOfWeek = forecastWeatherByDays?.weatherByDays[section].dayOfWeek ?? ""
        print(dayOfWeek)
        return headerView(dayOfWeek)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        let count = forecastWeatherByDays?.weatherByDays.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = forecastWeatherByDays?.weatherByDays[section].forecastWeather.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        let forecastWeather = forecastWeatherByDays?.weatherByDays[section].forecastWeather[row]
        
        let cell: ForecastCell = ForecastCell.init(style: .default, reuseIdentifier: "ForecastCell")

        cell.iconView.image = UIImage(named: forecastWeather?.elements.first?.icon ?? "")
        cell.temperatureLabel.text = "\(Int(round(forecastWeather?.mainValue.temp ?? 0)))°C"
        cell.timeLabel.text = "\(forecastWeather?.date.dateFromMilliseconds().hourMinute() ?? "")"
        cell.descriptionLabel.text = "\(forecastWeather?.elements.first?.weatherDescription ?? "")"
        
        return cell
    }
}

extension ForecastView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
