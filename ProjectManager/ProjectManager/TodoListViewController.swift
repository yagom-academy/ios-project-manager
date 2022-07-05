//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

class TodoListViewController: UIViewController {
    let mainView: UIView = TodoListView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Project Manager"
        configureView()
    }
    
    func configureView() {
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }


}

