//
//  TodoHistoryViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import UIKit
import SnapKit

protocol HistoryViewControllerDependencies: AnyObject {
    func dismissHistoryViewController()
}

class HistoryViewController: UIViewController {
    
    private let viewModel: HistoryViewModel
    private weak var coordinator: HistoryViewControllerDependencies?

    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoHistoryCell.self, forCellReuseIdentifier: TodoHistoryCell.identifier)
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    init(viewModel: HistoryViewModel, coordinator: HistoryViewControllerDependencies) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Setting
extension HistoryViewController {
    private func configureView() {
        
        
        self.view.addSubview(historyTableView)
        historyTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
