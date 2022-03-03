//
//  DoneViewController.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import UIKit

class DoneViewController: UIViewController {
    private let doneTableView = UITableView()
    lazy var dataSource = ToDoViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToDoTableView()
        setupConstraints()
    }
    
    private func setupToDoTableView() {
        view.addSubview(doneTableView)
        doneTableView.dataSource = dataSource
        doneTableView.register(
            ToDocell.self,
            forCellReuseIdentifier: "ToDocell"
        )
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            doneTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            doneTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            doneTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}
