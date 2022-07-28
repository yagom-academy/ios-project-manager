//
//  TodoHistoryViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import UIKit
import SnapKit
import RxSwift

protocol HistoryViewControllerDependencies: AnyObject {
    func dismissHistoryViewController()
}

final class HistoryViewController: UIViewController {
    
    private let viewModel: HistoryViewModel
    private weak var coordinator: HistoryViewControllerDependencies?
    private let bag = DisposeBag()

    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
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
            make.top.equalToSuperview().inset(24)
            make.bottom.leading.trailing.equalToSuperview().inset(8)
        }
    }
}

//MARK: - ViewModel Bind
extension HistoryViewController {
    private func bind() {
        viewModel.historyList
            .bind(to: historyTableView.rx.items(cellIdentifier: HistoryCell.identifier,
                                                cellType: HistoryCell.self)) { row, item, cell in
                cell.setContent(item: item)
            }.disposed(by: bag)
    }
}
