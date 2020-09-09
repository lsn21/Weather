//
//  ForecastViewController.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
       
        @IBOutlet weak var secondLabel: UILabel!
        var viewModel: ForecastViewModel!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            viewModel.viewDidLoad()
        }
    }
