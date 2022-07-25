//
//  TodoHistoryViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import UIKit
import SnapKit

class TodoHistoryViewController: UIViewController {

    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoHistoryCell.self, forCellReuseIdentifier: TodoHistoryCell.identifier)
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

//MARK: - View Setting
extension TodoHistoryViewController {
    private func configureView() {
        
        
        self.view.addSubview(historyTableView)
        historyTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
