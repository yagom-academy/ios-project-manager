//
//  CardListViewController.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/04.
//

import UIKit

import RxCocoa
import RxSwift
import Then

final class CardListViewController: UIViewController {
  private enum UISettings {
    static let intervalBetweenTableViews = 20.0
    static let navigationTitle = "Project Manager"
  }
  
  private let todoSectionView = CardSectionView(sectionType: .todo)
  private let doingSectionView = CardSectionView(sectionType: .doing)
  private let doneSectionView = CardSectionView(sectionType: .done)
  private lazy var containerStackView = UIStackView(
    arrangedSubviews: [todoSectionView, doingSectionView, doneSectionView]
  ).then {
    $0.axis = .horizontal
    $0.spacing = UISettings.intervalBetweenTableViews
    $0.distribution = .fillEqually
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private let viewModel = CardListViewModel()
  private let disposeBag = DisposeBag()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    configureSubViews()
    configureLayouts()
    configureTableViews()
    configureNavigationItem()
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
    
    bindSections(output: output)
  }
  
  private func bindSections(output: CardListViewModel.Output) {
    let todos = output.todoCards.asDriver()
    let doings = output.doingCards.asDriver()
    let dones = output.doneCards.asDriver()
    
    todos
      .drive(todoSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { _, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
    
    todos
      .map { "\($0.count)"}
      .drive(todoSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    doings
      .drive(doingSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { _, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
    
    doings
      .map { "\($0.count)" }
      .drive(doingSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    dones
      .drive(doneSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { _, card, cell in
        cell.setup(card: card)
      }
      .disposed(by: disposeBag)
    
    dones
      .map { "\($0.count)" }
      .drive(doneSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

// MARK: - UI Configuration

extension CardListViewController {
  private func configureNavigationItem() {
    title = UISettings.navigationTitle
  }
  
  private func configureTableViews() {
    [todoSectionView.tableView, doingSectionView.tableView, doneSectionView.tableView].forEach {
      $0.register(CardListTableViewCell.self, forCellReuseIdentifier: CardListTableViewCell.identifier)
    }
  }
  
  private func configureSubViews() {
    view.addSubview(containerStackView)
  }
  
  private func configureLayouts() {
    view.backgroundColor = .systemGray5
    
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
}
