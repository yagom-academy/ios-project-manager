//
//  TodoHistoryTableViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import UIKit
import Combine

final class TodoHistoryTableViewController: UITableViewController {
    private let viewModel: TodoHistoryTableViewModelable
    
    init(_ viewModel: TodoHistoryTableViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
