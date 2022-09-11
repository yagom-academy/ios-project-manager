//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    //MARK: - UI Properties
    
    private lazy var mainView = MainView(frame: view.safeAreaLayoutGuide.layoutFrame)
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItem()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        print("?")
    }
}

private extension MainViewController {
    
    //MARK: - Root View Setup
    
    func setupNavigationBarItem() {
        navigationItem.title = MainViewCommand.mainViewNavigationBarTitle
        view.backgroundColor = .systemGray5
        setupRightBarButtonItem()
    }
    
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
