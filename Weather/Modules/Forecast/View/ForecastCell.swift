//
//  ForecastCell.swift
//  Weather
//
//  Created by Siarhei on 10.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    lazy var iconView = makeIconView()
    lazy var temperatureLabel = makeTemperatureLabel()
    lazy var timeLabel = makeTimeLabel()
    lazy var descriptionLabel = makeDescriptionLabel()

    func makeIconView() -> UIImageView {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(8)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        return imageView
    }
    
    func makeTemperatureLabel() -> UILabel {
        let temperatureLabel = makeLabel(size: 28, color: .blue)
        temperatureLabel.textAlignment = .right
        temperatureLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-16)
            make.centerY.equalTo(contentView.center)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        return temperatureLabel
    }
    
    func makeTimeLabel() -> UILabel {
        let timeLabel = makeLabel(size: 20)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(iconView.snp.right).offset(8)
            make.right.equalTo(temperatureLabel).offset(-8)
            make.height.equalTo(20)
        }
        return timeLabel
    }
    
    func makeDescriptionLabel() -> UILabel {
        let descriptionLabel = makeLabel(size: 20)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.left.equalTo(iconView.snp.right).offset(8)
            make.right.equalTo(temperatureLabel).offset(-8)
            make.height.equalTo(20)
        }
        return descriptionLabel
    }
    
    func makeLabel(size: CGFloat, color: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size)
        addSubview(label)
        return label
    }
}
