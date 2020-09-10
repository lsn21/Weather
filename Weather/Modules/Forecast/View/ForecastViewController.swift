//
//  ForecastViewController.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
       
    var viewModel: ForecastViewModelProtocol!
    private var forecastView: ForecastView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
            viewModel = ForecastViewModel()

            createView()
            updateView()
        }
        
        private func createView() {
            forecastView = ForecastView()
            view.addSubview(forecastView)
            forecastView.snp.makeConstraints { make in
                make.top.equalTo(view)
                make.left.equalTo(view)
                make.right.equalTo(view)
                make.bottom.equalTo(view)
            }
        }
        
        private func updateView() {
            viewModel.updateViewData = { [weak self] viewData in
                guard let ws = self else { return }
                ws.forecastView.viewData = viewData
                switch viewData {
                case .loading:
                    break
                case .success(let success):
                    self?.navigationItem.title = success.city
                case .failure(let failure):
                    self?.navigationItem.title = failure.city
                }
            }
        }
    }
