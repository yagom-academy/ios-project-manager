//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ListViewController: UIViewController {
    var todoListView = ListView(category: .todo)
    var doingListView = ListView(category: .doing)
    var doneListView = ListView(category: .done)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray3
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemGray6
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoListView)
        stackView.addArrangedSubview(doingListView)
        stackView.addArrangedSubview(doneListView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let addViewController = AddViewController()
        let navigationViewController = UINavigationController(rootViewController: addViewController)
        navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationViewController, animated: true)
    }
    
}
