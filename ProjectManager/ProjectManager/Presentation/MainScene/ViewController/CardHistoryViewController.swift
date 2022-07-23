//
//  CardHistoryViewController.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/21.
//

import UIKit

import RxCocoa
import RxSwift

final class CardHistoryViewController: UIViewController, PopOverable {
  private let tableView = UITableView().then {
    $0.showsVerticalScrollIndicator = false
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(
      CardHistoryTableViewCell.self,
      forCellReuseIdentifier: CardHistoryTableViewCell.identifier
    )
  }
  
  private let disposeBag = DisposeBag()
  private let histories = BehaviorRelay<[CardHistoryViewModelItem]>(value: [])
  
  init(histories: [CardHistoryViewModelItem]) {
    self.histories.accept(histories)
    super.init(nibName: nil, bundle: nil)
    configureSubviews()
    configureLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindUI()
  }
  
  private func bindUI() {
    histories
      .bind(to: tableView.rx.items(
        cellIdentifier: CardHistoryTableViewCell.identifier,
        cellType: CardHistoryTableViewCell.self
      )) { index, history, cell in
        cell.setup(history: history)
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - UI Configuration

extension CardHistoryViewController {
  private func configureSubviews() {
    view.addSubview(tableView)
  }

  private func configureLayouts() {
    view.backgroundColor = .systemBackground
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}
