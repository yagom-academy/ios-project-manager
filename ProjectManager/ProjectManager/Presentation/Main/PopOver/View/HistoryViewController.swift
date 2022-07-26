//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/25.
//

import RxCocoa
import RxSwift

final class HistoryViewController: UIViewController {
    private let historyView = HistoryView()
    private let viewModel = HistoryViewModel()
    private let disposeBag = DisposeBag()
    
    init(source: UIBarButtonItem) {
        super.init(nibName: nil, bundle: nil)
        
        setUpAttribute(source)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = historyView
    }
    
    override func viewDidLoad() {
        bind()
    }
    
    private func setUpAttribute(_ source: UIBarButtonItem) {
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(
            width: 600,
            height: UIScreen.main.bounds.size.height * 0.8
        )
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.barButtonItem = source
    }
    
    private func bind() {
        setUpTable()
    }
    
    private func setUpTable() {
        viewModel
            .read()
            .drive(
                historyView.tableView.rx.items(
                    cellIdentifier: "\(HistoryCell.self)",
                    cellType: HistoryCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
    }
}
