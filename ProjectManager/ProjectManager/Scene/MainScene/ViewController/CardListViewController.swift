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
  private enum UISettings {
    static let intervalBetweenTableViews = 20.0
    static let navigationTitle = "Project Manager"
  }
  
  private let todoTableView = UITableView()
  private let doingTableView = UITableView()
  private let doneTableView = UITableView()
  
  private let todoHeaderView = CardListHeaderView(cardType: .todo)
  private let doingHeaderView = CardListHeaderView(cardType: .doing)
  private let doneHeaderView = CardListHeaderView(cardType: .done)

  private let viewModel = CardListViewModel()
  private let disposeBag = DisposeBag()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    configureNavigationBar()
    configureTableView()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindUI()
  }
  
  private func bindUI() {
    let input = CardListViewModel.Input()
    let output = viewModel.transform(input: input)
    
    let todos = output.cards.map { $0.filter { $0.cardType == .todo } }
    let doings = output.cards.map { $0.filter { $0.cardType == .doing } }
    let dones = output.cards.map { $0.filter { $0.cardType == .done } }
    
    todos
      .drive(todoTableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { index, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
    
    doings
      .drive(doingTableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { index, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
    
    dones
      .drive(doneTableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { index, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
    
    todos
      .map { "\($0.count)" }
      .drive(todoHeaderView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    doings
      .map { "\($0.count)" }
      .drive(doingHeaderView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    dones
      .map { "\($0.count)" }
      .drive(doneHeaderView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    todoTableView.rx.itemSelected
      .withUnretained(self)
      .bind(onNext: { (wself, indexPath) in
        wself.todoTableView.deselectRow(at: indexPath, animated: true)
      })
      .disposed(by: disposeBag)
    
    doingTableView.rx.itemSelected
      .withUnretained(self)
      .bind(onNext: { (wself, indexPath) in
        wself.doingTableView.deselectRow(at: indexPath, animated: true)
      })
      .disposed(by: disposeBag)
    
    doneTableView.rx.itemSelected
      .withUnretained(self)
      .bind(onNext: { (wself, indexPath) in
        wself.doneTableView.deselectRow(at: indexPath, animated: true)
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - UI Configuration

extension CardListViewController {
  private func configureNavigationBar() {
    title = UISettings.navigationTitle
  }
  
  private func configureTableView() {
    [todoTableView, doingTableView, doneTableView].forEach {
      $0.register(CardListTableViewCell.self, forCellReuseIdentifier: CardListTableViewCell.identifier)
    }
  }
  
  private func configureUI() {
    view.backgroundColor = .systemGray5
    let tableViews = [todoTableView, doingTableView, doneTableView]
    tableViews.forEach { $0.backgroundColor = .systemGray6 }
    
    let todoContainerStackView = UIStackView(arrangedSubviews: [todoHeaderView, todoTableView])
    todoContainerStackView.axis = .vertical
    let doingContainerStackView = UIStackView(arrangedSubviews: [doingHeaderView, doingTableView])
    doingContainerStackView.axis = .vertical
    let doneContainerStackView = UIStackView(arrangedSubviews: [doneHeaderView, doneTableView])
    doneContainerStackView.axis = .vertical
    
    let subContainers = [todoContainerStackView, doingContainerStackView, doneContainerStackView]
    
    let containerStackView = UIStackView(arrangedSubviews: subContainers)
    containerStackView.axis = .horizontal
    containerStackView.spacing = UISettings.intervalBetweenTableViews
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
