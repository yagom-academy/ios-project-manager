//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

    lazy var todoTableView = makeTableView()
    lazy var doingTableView = makeTableView()
    lazy var doneTableView = makeTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func makeTableView() -> UITableView {
        let tableView = UITableView()
        return tableView
    }
}

