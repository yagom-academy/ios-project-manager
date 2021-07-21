//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    lazy var todoTableView: UITableView = {
        let todoTableView: UITableView = UITableView()
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        return todoTableView
    }()
    
    lazy var doingTableView: UITableView = {
        let doingTableView: UITableView = UITableView()
        doingTableView.translatesAutoresizingMaskIntoConstraints = false
        return doingTableView
    }()
    
    lazy var doneTableView: UITableView = {
        let doneTableView: UITableView = UITableView()
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
        return doneTableView
    }()
    
    lazy var tablesStackView: UIStackView = {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private func addSubViews() {
        self.view.addSubview(tablesStackView)
    }
    
    private func configureConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tablesStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tablesStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tablesStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tablesStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        self.view.backgroundColor = .white
        addSubViews()
        configureConstraints()
    }
}
