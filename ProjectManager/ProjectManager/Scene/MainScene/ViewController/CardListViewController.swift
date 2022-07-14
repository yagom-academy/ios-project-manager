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
    static let navigationTitle = "Project Manager"
    static let cardAdditionButtonImage = "plus"
    static let intervalBetweenTableViews = 20.0
  }
  
  private let todoSectionView = CardSectionView(sectionType: .todo)
  private let doingSectionView = CardSectionView(sectionType: .doing)
  private let doneSectionView = CardSectionView(sectionType: .done)
  
  private let cardAdditionButton = UIBarButtonItem().then {
    $0.image = UIImage(systemName: UISettings.cardAdditionButtonImage)
  }
  private let containerStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = UISettings.intervalBetweenTableViews
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private let disposeBag = DisposeBag()
  private weak var viewModel: CardListViewModelable?
  private weak var coordinator: CardCoordinator?
  
  init(viewModel: CardListViewModelable, coordinator: CardCoordinator) {
    self.viewModel = viewModel
    self.coordinator = coordinator
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
    bindSectionsHeader()
    bindSectionsItems()
    bindSectionsItemSelected()
    bindSectionsItemDeleted()
    bindSectionsLongPressed()
    
    cardAdditionButton.rx.tap
      .bind(onNext: { [weak self] in
        guard let self = self else { return }
        self.coordinator?.toAddition()
      })
      .disposed(by: disposeBag)
  }
  
  private func bindSectionsHeader() {
    viewModel?.todoCards
      .map { "\($0.count)" }
      .drive(todoSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel?.doingCards
      .map { "\($0.count)" }
      .drive(doingSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel?.doneCards
      .map { "\($0.count)" }
      .drive(doneSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
  }
  
  private func bindSectionsItems() {
    viewModel?.todoCards
      .drive(todoSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { [weak self] _, card, cell in
        guard let self = self else { return }
        cell.setup(card: self.viewModel?.toCardListViewModelItem(card: card))
      }
      .disposed(by: disposeBag)
    
    viewModel?.doingCards
      .drive(doingSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { [weak self] _, card, cell in
        guard let self = self else { return }
        cell.setup(card: self.viewModel?.toCardListViewModelItem(card: card))
      }
      .disposed(by: disposeBag)
    
    viewModel?.doneCards
      .drive(doneSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { [weak self] _, card, cell in
        guard let self = self else { return }
        cell.setup(card: self.viewModel?.toCardListViewModelItem(card: card))
      }
      .disposed(by: disposeBag)
  }
  
  private func bindSectionsItemSelected() {
    Observable.zip(
      todoSectionView.tableView.rx.itemSelected,
      todoSectionView.tableView.rx.modelSelected(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      guard let self = self else { return }
      self.todoSectionView.tableView.deselectRow(at: indexPath, animated: true)
      self.coordinator?.toDetail(of: card)
    })
    .disposed(by: disposeBag)
    
    Observable.zip(
      doingSectionView.tableView.rx.itemSelected,
      doingSectionView.tableView.rx.modelSelected(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      guard let self = self else { return }
      self.doingSectionView.tableView.deselectRow(at: indexPath, animated: true)
      self.coordinator?.toDetail(of: card)
    })
    .disposed(by: disposeBag)
    
    Observable.zip(
      doneSectionView.tableView.rx.itemSelected,
      doneSectionView.tableView.rx.modelSelected(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      guard let self = self else { return }
      self.doneSectionView.tableView.deselectRow(at: indexPath, animated: true)
      self.coordinator?.toDetail(of: card)
    })
    .disposed(by: disposeBag)
  }
  
  private func bindSectionsItemDeleted() {
    Observable.merge(
      todoSectionView.tableView.rx.modelDeleted(Card.self).asObservable(),
      doingSectionView.tableView.rx.modelDeleted(Card.self).asObservable(),
      doneSectionView.tableView.rx.modelDeleted(Card.self).asObservable()
    )
    .bind(onNext: { [weak self] card in
      self?.viewModel?.deleteSelectedCard(card)
    })
    .disposed(by: disposeBag)
  }
  
  private func bindSectionsLongPressed() {
    Observable.merge(
      todoSectionView.tableView.rx.modelLongPressed(Card.self).asObservable(),
      doingSectionView.tableView.rx.modelLongPressed(Card.self).asObservable(),
      doneSectionView.tableView.rx.modelLongPressed(Card.self).asObservable()
    )
    .flatMap { [weak self] cell, card in
      Observable.zip(
        Observable.just(card),
        UIAlertController.presentPopOver(self, with: .init(card: card), on: cell)
      )
    }
    .bind(onNext: { [weak self] card, index in
      self?.viewModel?.moveDifferentSection(card, to: index)
    })
    .disposed(by: disposeBag)
  }
}

// MARK: - UI Configuration

extension CardListViewController {
  private func configureNavigationItem() {
    title = UISettings.navigationTitle
    navigationItem.rightBarButtonItem = cardAdditionButton
  }
  
  private func configureTableViews() {
    [todoSectionView.tableView, doingSectionView.tableView, doneSectionView.tableView].forEach {
      $0.register(CardListTableViewCell.self, forCellReuseIdentifier: CardListTableViewCell.identifier)
    }
  }
  
  private func configureSubViews() {
    view.addSubview(containerStackView)
    [todoSectionView, doingSectionView, doneSectionView].forEach { containerStackView.addArrangedSubview($0) }
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
