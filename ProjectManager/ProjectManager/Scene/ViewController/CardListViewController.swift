//
//  CardListViewController.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/04.
//

import UIKit
import RxSwift
import RxCocoa

final class CardListViewController: UIViewController {
  private let todoTableView = UITableView()
  private let doingTableView = UITableView()
  private let doneTableView = UITableView()

  private let viewModel = CardListViewModel()
  private let disposeBag = DisposeBag()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    bindUI()
  }
  
  private func bindUI() {
    let input = CardListViewModel.Input()
    let output = viewModel.transform(input: input)
    
    output.cards
      .map { $0.filter { $0.cardType == .todo } }
      .drive(todoTableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { index, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
    
    output.cards
      .map { $0.filter { $0.cardType == .doing } }
      .drive(doingTableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { index, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
    
    output.cards
      .map { $0.filter { $0.cardType == .done } }
      .drive(doneTableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { index, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
  }
  
  private func configureTableView() {
    todoTableView.register(CardListTableViewCell.self, forCellReuseIdentifier: CardListTableViewCell.identifier)
    doingTableView.register(CardListTableViewCell.self, forCellReuseIdentifier: CardListTableViewCell.identifier)
    doneTableView.register(CardListTableViewCell.self, forCellReuseIdentifier: CardListTableViewCell.identifier)
  }
  
  private func configureUI() {
    view.backgroundColor = .systemGray4
    let tableViews = [todoTableView, doingTableView, doneTableView]
    tableViews.forEach { $0.backgroundColor = .systemGray5 }
    
    let containerStackView = UIStackView(arrangedSubviews: tableViews)
    containerStackView.axis = .horizontal
    containerStackView.spacing = 20.0
    containerStackView.distribution = .fillEqually
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(containerStackView)
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
}
