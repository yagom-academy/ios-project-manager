//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

    var viewModel: MainViewModel
    let tableView = UITableView()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }

    func configure() {
        self.view.backgroundColor = .white
        self.title = "ProjectManager"

        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
    }

}
