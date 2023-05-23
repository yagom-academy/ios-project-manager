//
//  ProjectManager - MainViewController.swift
//  Created by songjun, vetto. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let mainViewModel = MainViewModel()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .lightGray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var todoView = TodoView(viewModel: mainViewModel)
    private lazy var doingView = DoingView(viewModel: mainViewModel)
    private lazy var doneView = DoneView(viewModel: mainViewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        todoView.configureUI()
        todoView.configureDataSource()
        todoView.configureStackView()
        doingView.configureUI()
        doingView.configureDataSource()
        doingView.configureStackView()
        doneView.configureUI()
        doneView.configureDataSource()
        doneView.configureStackView()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let buttonItem: UIBarButtonItem = {
            let button = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(tabPlusButton))
            
            return button
        }()
        
        navigationItem.rightBarButtonItem = buttonItem
        self.title = "ProjectManager"
    }
    
    @objc func tabPlusButton() {
        presentEditModal()
    }
    
    private func presentEditModal() {
        let modalViewController = ModalViewController(viewModel: mainViewModel)
        let modalNavigationController = UINavigationController(rootViewController: modalViewController)
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.preferredContentSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.7)
        
        present(modalNavigationController, animated: true, completion: nil)
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoView)
        stackView.addArrangedSubview(doingView)
        stackView.addArrangedSubview(doneView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
