//
//  TodoHistoryViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import UIKit
import SnapKit

protocol TodoHistoryViewControllerDependencies: AnyObject {
    func dismissHistoryViewController()
}

class TodoHistoryViewController: UIViewController {
    
    private let viewModel: TodoHistoryViewModel
    private weak var coordinator: TodoHistoryViewControllerDependencies?

    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoHistoryCell.self, forCellReuseIdentifier: TodoHistoryCell.identifier)
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    init(viewModel: TodoHistoryViewModel, coordinator: TodoHistoryViewControllerDependencies) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
