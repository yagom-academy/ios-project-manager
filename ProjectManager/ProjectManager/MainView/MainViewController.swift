//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import Foundation

import UIKit

final class MainViewController: UIViewController {
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildren()
        configureNavigationBar()
        configureRootView()
        configureStackView()
        setupViewModelReference()
        fetchInitialTaskList()
    }

    private func configureNavigationBar() {
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(presentDetailView)
        )
    }
    
    @objc
    private func presentDetailView() {
        let detailViewModelDelegate = mainViewModel.todoViewModel() as? DetailViewModelDelegate
        let detailViewController = DetailViewController(task: nil, mode: .create)
        detailViewController.modalPresentationStyle = .formSheet
        detailViewController.configureViewModelDelegate(with: detailViewModelDelegate)
        
        self.present(detailViewController, animated: true)
    }
    
    private func configureRootView() {
        view.backgroundColor = .systemGray4
        view.addSubview(stackView)
    }
    
    private func addChildren() {
        self.addChild(TaskCollectionViewController(viewModel: TodoViewModel()))
        self.addChild(TaskCollectionViewController(viewModel: DoingViewModel()))
        self.addChild(TaskCollectionViewController(viewModel: DoneViewModel()))
    }
    
    private func setupViewModelReference() {
        self.mainViewModel.assignChildViewModel(of: self.children)
    }
    
    private func configureStackView() {
        self.children.forEach {
            stackView.addArrangedSubview($0.view)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func fetchInitialTaskList() {
        mainViewModel.fetchTaskList()
        mainViewModel.distributeTask()
    }
}
