//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

final class TodoListViewController: UIViewController {
    let mainView: UIView = TodoListView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Project Manager"
        configureView()
    }
    
    private func configureView() {
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

