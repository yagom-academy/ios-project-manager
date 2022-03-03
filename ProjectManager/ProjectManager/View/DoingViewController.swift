//
//  DoingViewController.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import UIKit

class DoingViewController: UIViewController {
    private let doingTableView = UITableView()
    lazy var dataSource = TaskDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToDoTableView()
        setupConstraints()
    }
    
    private func setupToDoTableView() {
        view.addSubview(doingTableView)
        doingTableView.dataSource = dataSource
        doingTableView.register(
            ToDocell.self,
            forCellReuseIdentifier: "ToDocell"
        )
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        doingTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doingTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            doingTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            doingTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            doingTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}
