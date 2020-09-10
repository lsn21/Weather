//
//  TodayViewController.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit
import SnapKit

class TodayViewController: UIViewController {

    var viewModel: TodayViewModelProtocol!
    private var todayView: TodayView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TodayViewModel()

        title = "Today"
        
        createView()
        updateView()
    }
    
    private func createView() {
        todayView = TodayView()
        todayView.delegate = self
        view.addSubview(todayView)
        todayView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            guard let ws = self else { return }
            ws.todayView.viewData = viewData
        }
    }
}
