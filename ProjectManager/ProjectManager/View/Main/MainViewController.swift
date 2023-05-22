//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let viewModel = WorkViewModel()
    private let todoCollectionView: WorkCollectionView
    private let doingCollectionView: WorkCollectionView
    private let doneCollectionView: WorkCollectionView
    
    init() {
        self.todoCollectionView = WorkCollectionView(status: WorkStatus.todo.title, viewModel: viewModel)
        self.doingCollectionView = WorkCollectionView(status: WorkStatus.doing.title, viewModel: viewModel)
        self.doneCollectionView = WorkCollectionView(status: WorkStatus.done.title, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
        configureCollectionListView()
    }
    
    private func configureUIOption() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(moveToAppendWork))
    }
    
    @objc private func moveToAppendWork() {
        let detailViewController = DetailViewController()
        detailViewController.configureAddMode()
        let navigationController = UINavigationController(rootViewController: detailViewController)
        
        self.present(navigationController, animated: true)
    }
}

// MARK: - Collection View Setting
extension MainViewController {
    private func configureCollectionListView() {
        let stackView = createStackView()
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [todoCollectionView, doingCollectionView, doneCollectionView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }
}
