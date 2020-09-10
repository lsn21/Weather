//
//  TodayView.swift
//  Weather
//
//  Created by Siarhei on 09.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

class TodayView: UIView {
    
    var delegate: TodayViewController?
    
    var viewData: TodayViewData = .loading {
        didSet {
            setNeedsLayout()
        }
    }
    var currentWeather: CurrentWeather?
    
    lazy var activityIndicator = makeActivityIndicatorView()
    lazy var imageView = makeImageView()
    lazy var cityLabel = makeCityLabel()
    lazy var temperatureLabel = makeTemperatureLabel()

    lazy var humidityLabel = makeHumidityLabel()
    lazy var pressureLabel = makePressureLabel()
    lazy var windSpeedLabel = makeWindSpeedLabel()
    lazy var windDirectionLabel = makeWindDirectionLabel()
    var shareButton: UIButton?

    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .loading:
            update(viewData: nil, isHidden: true)
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .success(let success):
            update(viewData: success, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .failed(let failed):
            update(viewData: nil, isHidden: true)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            if failed {
                showMessage(message: "Error retrieving data from the server.")
            }
            else {
                showMessage(message: "Internet connection not available.")
            }
        }
    }
    
    func showMessage(message: String) {
        let alertView = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        delegate?.present(alertView, animated: true, completion: nil)
    }

    private func update(viewData: CurrentWeather?, isHidden: Bool) {
        currentWeather = viewData
        shareButton = makeShareButton()
        imageView.image = UIImage(named: viewData?.elements.first?.icon ?? "")
        cityLabel.text = "\(viewData?.name ?? ""), \(viewData?.sys.country ?? "")"
        temperatureLabel.text = "\(Int(round(viewData?.mainValue.temp ?? 0)))°C | \(viewData?.elements.first?.main ?? "")"
        
        humidityLabel.text = "Humidity: \(viewData?.mainValue.humidity ?? 0)%"
        pressureLabel.text = "Pressure: \(viewData?.mainValue.pressure ?? 0) hPa"
        windSpeedLabel.text = "Wind speed: \(viewData?.wind.speed ?? 0) km/h"
        windDirectionLabel.text = "Wind direction: \(windDirection(viewData?.wind.deg ?? 0))"

        imageView.isHidden = isHidden
        cityLabel.isHidden = isHidden
        temperatureLabel.isHidden = isHidden
        humidityLabel.isHidden = isHidden
        pressureLabel.isHidden = isHidden
        windSpeedLabel.isHidden = isHidden
        windDirectionLabel.isHidden = isHidden
        shareButton?.isHidden = isHidden
    }
    
    func windDirection(_ deg: Int) -> String {
        var direction = ""
        
        switch deg {
        case 0...22, 338...360:
            direction = "N"
        case 23...67:
            direction = "NE"
        case 68...112:
            direction = "E"
        case 113...157:
            direction = "SE"
        case 158...202:
            direction = "S"
        case 203...247:
            direction = "SW"
        case 248...292:
            direction = "W"
        case 293...337:
            direction = "NW"
        default:
            direction = ""
        }
        return direction
    }
}
