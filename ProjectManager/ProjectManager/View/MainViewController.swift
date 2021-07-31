//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    private let navigationItemTitleText = "Project Manager"

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
    }

    private func setNavigation() {
        self.navigationItem.title = navigationItemTitleText
    }
}
