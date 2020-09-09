//
//  TodayView + Extension.swift
//  Weather
//
//  Created by Siarhei on 09.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

extension TodayView {
    
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

    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(64)
            make.centerX.equalTo(self.center)
            make.width.equalTo(128)
            make.height.equalTo(128)
        }
        return imageView
    }
    
    func makeCityLabel() -> UILabel {
        let cityLabel = makeLabel(size: 20)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(0)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(20)
        }
        return cityLabel
    }
    
    func makeTemperatureLabel() -> UILabel {
        let temperatureLabel = makeLabel(size: 24, color: .blue)
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(16)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(24)
        }
        return temperatureLabel
    }
    
    func makeHumidityLabel() -> UILabel {
        let humidityLabel = makeLabel(size: 20)
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(32)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(20)
        }
        return humidityLabel
    }
    
    func makePressureLabel() -> UILabel {
        let pressureLabel = makeLabel(size: 20)
        pressureLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(16)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(20)
        }
        return pressureLabel
    }
    
    func makeWindSpeedLabel() -> UILabel {
        let windSpeedLabel = makeLabel(size: 20)
        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(pressureLabel.snp.bottom).offset(16)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(20)
        }
        return windSpeedLabel
    }
    
    func makeWindDirectionLabel() -> UILabel {
        let windDirectionLabel = makeLabel(size: 20)
        windDirectionLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(16)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(20)
        }
        return windDirectionLabel
    }
    
    func makeLabel(size: CGFloat, color: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size)
        label.textAlignment = .center
        addSubview(label)
        return label
    }
}
