//
//  SecondViewController.swift
//  ProjectManager
//
//  Created by Jusbug on 2023/09/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        configureTitle()
    }

    private func configureTitle() {
        self.navigationItem.title = "TODO"
    }
}
