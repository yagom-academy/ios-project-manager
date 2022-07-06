//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    private lazy var mainView = MainView()
    
    override func loadView() {
        view = mainView
        mainView.setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
