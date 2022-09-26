//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/23.
//

import UIKit
import RxSwift

final class HistoryViewController: UIViewController {
    // MARK: - UI
    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.separatorInset = .zero
        return tableView
    }()
    
    // MARK: - Properties
    private let viewModel: WorkViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - initializer
    init(viewModel: WorkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    private func setupView() {
        self.view.addSubview(historyTableView)
        
        NSLayoutConstraint.activate([
            historyTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            historyTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.histories
            .asDriver(onErrorJustReturn: [])
            .drive(historyTableView.rx.items(cellIdentifier: HistoryTableViewCell.identifier,
                                         cellType: HistoryTableViewCell.self)) { _, item, cell in
                cell.configure(with: item)
            }.disposed(by: disposeBag)
    }
}
