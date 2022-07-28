//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/27.
//

import RxSwift

final class HistoryViewController: UIViewController {
    let viewModel: HistoryViewModelable
    
    init(viewModel: HistoryViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let historyView = HistoryView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = historyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        viewModel.hitory
            .bind(to: historyView.historyTableView.rx.items(cellIdentifier: "\(HistoryTableViewCell.self)", cellType: HistoryTableViewCell.self)) { index, item, cell in
                cell.setCellContents(item)
        }
        .disposed(by: disposeBag)
        
        historyView.historyTableView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.historyView.historyTableView.deselectRow(at: $0, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
