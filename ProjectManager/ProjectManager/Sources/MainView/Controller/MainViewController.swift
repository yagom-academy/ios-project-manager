//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import CoreData
import CloudKit

class MainViewController: UIViewController {
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItem()
    }
}


private extension MainViewController {
    
    //MARK: - Root View Setup
    
    func setupNavigationBarItem() {
        navigationItem.title = MainViewCommand.mainViewNavigationBarTitle
        view.backgroundColor = .systemBackground
        setupRightBarButtonItem()
    }
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        navigationItem.rightBarButtonItem  = rightBarButtonItem    
    }
}
