//
//  ProjectManager - ToDoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
//  Last modified by Max.

import UIKit

protocol ToDoListViewDelegate: AnyObject {
    var viewModel: ToDoListViewModel { get set }
}

class ToDoListViewController: UIViewController, ToDoListViewDelegate {
    var viewModel: ToDoListViewModel
    
    private let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .top
            stackView.spacing = 10
            return stackView
        }()
        
        private let toDoView: ToDoListView
        private let doingView: ToDoListView
        private let doneView: ToDoListView
    
    init(_ dataManager: CoreDataManager) {
        self.viewModel = ToDoListViewModel(dataManager: dataManager)
        self.toDoView = ToDoListView(.toDo)
        self.doingView = ToDoListView(.doing)
        self.doneView = ToDoListView(.done)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBar()
        setupView()
        setupBinding()
    }
    
    private func setupUI() {
           let safeArea = view.safeAreaLayoutGuide
           view.backgroundColor = .systemBackground
           stackView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
           
           stackView.addArrangedSubview(toDoView)
           stackView.addArrangedSubview(doingView)
           stackView.addArrangedSubview(doneView)
           view.addSubview(stackView)
           
           NSLayoutConstraint.activate([
               stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
               stackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
               stackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
               stackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
               toDoView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
               toDoView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
               doingView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
               doingView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
               doneView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
               doneView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
           ])
       }
       
       private func setupNavigationBar() {
           self.title = "Project Manager"
           let addToDo = UIAction(image: UIImage(systemName: "plus")) { _ in }
           navigationItem.rightBarButtonItem = UIBarButtonItem(primaryAction: addToDo)
       }
       
       private func setupView() {
           toDoView.delegate = self
           doingView.delegate = self
           doneView.delegate = self
       }
       
       private func readData() {
           viewModel.fetchData()
       }
       
       private func setupBinding() {
           viewModel.dataList.bind { [weak self] _ in
               guard let self else { return }
               self.toDoView.reloadTableView()
               self.doingView.reloadTableView()
               self.doneView.reloadTableView()
           }
           
           viewModel.error.bind { [weak self] _ in
               guard let self,
                     let error = viewModel.error.value else { return }
               let alertBuilder = AlertBuilder(viewController: self, prefferedStyle: .alert)
               alertBuilder.setControllerTitle(title: error.alertTitle)
               alertBuilder.setControllerMessage(message: error.alertMessage)
               alertBuilder.addAction(.confirm)
               let alertController = alertBuilder.makeAlertController()
               present(alertController, animated: true)
           }
       }
}

