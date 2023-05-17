//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
//    private lazy var stackView: UIStackView = {
//        let stackView = UIStackView(frame: view.bounds)
//        stackView.backgroundColor = .brown
//        stackView.distribution = .fillEqually
//        stackView.axis = .horizontal
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        return stackView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view = stackView
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.title = "ProjectManager"
    }
}

struct collectionViewContent {
    let title: String
    let detail: String
    let expirationDate: String
}
