//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let todoHeaderView = HeaderVIew(MenuType.todo)
    private let doingHeaderView = HeaderVIew(MenuType.doing)
    private let doneHeaderView = HeaderVIew(MenuType.done)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitailView()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.title = "Project Manger"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    private func setInitailView() {
        self.view.backgroundColor = .systemGray5
        self.view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(todoStackView)
        mainStackView.addArrangedSubview(doingStackView)
        mainStackView.addArrangedSubview(doneStackView)
        mainStackView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    
    private lazy var todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.addArrangedSubview(todoHeaderView)
        stackView.addArrangedSubview(todoTableView)
        
        return stackView
    }()
    
    private lazy var todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private lazy var doingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.addArrangedSubview(doingHeaderView)
        stackView.addArrangedSubview(doingTableView)
        
        return stackView
    }()
    
    private lazy var doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private lazy var doneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.addArrangedSubview(doneHeaderView)
        stackView.addArrangedSubview(doneTableView)
        
        return stackView
    }()
    
    private lazy var doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
}

