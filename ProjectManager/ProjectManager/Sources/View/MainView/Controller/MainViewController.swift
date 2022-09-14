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
    private let viewModel = ProjectTaskViewModel()
    private let disposeBad = DisposeBag()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupNavigationBarItem()
        setupBinding()
    }
}

private extension MainViewController {
    
    //MARK: - Root View Setup
    func setupMainView() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationBarItem() {
        navigationItem.title = MainViewCommand.mainViewNavigationBarTitle
        view.backgroundColor = .systemGray5
        setupRightBarButtonItem()
    }
    
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(rightBarButtonDidTap)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc func rightBarButtonDidTap() {
        let todoAddViewController = TodoAddViewController()
        todoAddViewController.state = .TODO
        
        let presentNavigationController = UINavigationController(rootViewController: todoAddViewController)
        presentNavigationController.modalPresentationStyle = .pageSheet
        
        self.navigationController?.present(presentNavigationController, animated: true)
    }
    
    //MARK: Binding ViewModel
    
    func setupBinding() {
        setupTableViewBinding()
        setupHeaderCountBinding()
        setupTaskSelectedBinding()
    }
    
    
    func setupTableViewBinding() {
        
    }
    
    func setupHeaderCountBinding() {

    }
    
    func setupTaskSelectedBinding() {
        
    }
}
