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
    
    func makeShareButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.addTarget(self, action: #selector(shareButtonTapped(_:)), for: .touchUpInside)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(windDirectionLabel.snp.bottom).offset(32)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(44)
        }
        return button
    }
    
    func makeLabel(size: CGFloat, color: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size)
        label.textAlignment = .center
        addSubview(label)
        return label
    }
    
    @objc func shareButtonTapped(_ sender: Any) {
        
        let activityItem = "Weather for today:\n\(currentWeather?.name ?? ""), \(currentWeather?.sys.country ?? "")\nHumidity: \(currentWeather?.mainValue.humidity ?? 0)%\nPressure: \(currentWeather?.mainValue.pressure ?? 0) hPa\nWind speed: \(currentWeather?.wind.speed ?? 0) km/h\nWind direction: \(windDirection(currentWeather?.wind.deg ?? 0))"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [activityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
        UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        delegate?.present(activityViewController, animated: true, completion: nil)
    }
}
