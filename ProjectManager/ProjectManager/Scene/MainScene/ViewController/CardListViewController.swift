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
  private let viewModel: CardListViewModelable
  
  init(viewModel: CardListViewModelable) {
    self.viewModel = viewModel
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
        let cardAdditionViewController = CardAdditionViewController(viewModel: self.viewModel)
        cardAdditionViewController.modalPresentationStyle = .formSheet
        self.present(cardAdditionViewController, animated: true)
      })
      .disposed(by: disposeBag)
  }
  
  private func bindSectionsHeader() {
    viewModel.todoCards
      .map { "\($0.count)" }
      .drive(todoSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.doingCards
      .map { "\($0.count)" }
      .drive(doingSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.doneCards
      .map { "\($0.count)" }
      .drive(doneSectionView.headerView.cardCountLabel.rx.text)
      .disposed(by: disposeBag)
  }
  
  private func bindSectionsItems() {
    viewModel.todoCards
      .drive(todoSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { [weak self] _, card, cell in
        guard let self = self else { return }
        cell.setup(card: self.viewModel.toCardListViewModelItem(card: card))
      }
      .disposed(by: disposeBag)
    
    viewModel.doingCards
      .drive(doingSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { [weak self] _, card, cell in
        guard let self = self else { return }
        cell.setup(card: self.viewModel.toCardListViewModelItem(card: card))
      }
      .disposed(by: disposeBag)
    
    viewModel.doneCards
      .drive(doneSectionView.tableView.rx.items(
        cellIdentifier: CardListTableViewCell.identifier,
        cellType: CardListTableViewCell.self
      )) { [weak self] _, card, cell in
        guard let self = self else { return }
        cell.setup(card: self.viewModel.toCardListViewModelItem(card: card))
      }
      .disposed(by: disposeBag)
  }
  
  private func bindSectionsItemSelected() {
    Observable.of(
      Observable.zip(
        todoSectionView.tableView.rx.itemSelected,
        todoSectionView.tableView.rx.modelSelected(Card.self)
      ),
      Observable.zip(
        doingSectionView.tableView.rx.itemSelected,
        doingSectionView.tableView.rx.modelSelected(Card.self)
      ),
      Observable.zip(
        doneSectionView.tableView.rx.itemSelected,
        doneSectionView.tableView.rx.modelSelected(Card.self)
      )
    )
    .merge()
    .bind(onNext: { [weak self] indexPath, card in
      guard let self = self else { return }
      self.todoSectionView.tableView.deselectRow(at: indexPath, animated: true)
      let cardDetailViewController = CardDetailViewController(viewModel: self.viewModel, card: card)
      cardDetailViewController.modalPresentationStyle = .formSheet
      self.present(cardDetailViewController, animated: true)
    })
    .disposed(by: disposeBag)
  }
  
  private func bindSectionsItemDeleted() {
    Observable.of(
      todoSectionView.tableView.rx.modelDeleted(Card.self),
      doingSectionView.tableView.rx.modelDeleted(Card.self),
      doneSectionView.tableView.rx.modelDeleted(Card.self)
    )
    .merge()
    .bind(onNext: { [weak self] card in
      self?.viewModel.deleteSelectedCard(card)
    })
    .disposed(by: disposeBag)
  }
  
  private func bindSectionsLongPressed() {
    Observable.of(
      todoSectionView.tableView.rx.modelLongPressed(Card.self),
      doingSectionView.tableView.rx.modelLongPressed(Card.self),
      doneSectionView.tableView.rx.modelLongPressed(Card.self)
    )
    .merge()
    .withUnretained(self)
    .flatMap { wself, item -> Observable<(Card, CardType)> in
      let (first, second) = wself.distinguishMenuType(of: item.1)
      let popover = wself.showPopover(
        sourceView: item.0,
        firstTitle: first.moveToMenuTitle,
        secondTitle: second.moveToMenuTitle
      )
      return Observable.zip(
        Observable.just(item.1),
        popover.map { [first, second][$0] }
      )
    }
    .bind(onNext: { [weak self] card, cardType in
      self?.viewModel.moveDifferentSection(card, to: cardType)
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

// MARK: - Alert

extension CardListViewController {
  private func showPopover(
    sourceView: UIView,
    firstTitle: String,
    secondTitle: String
  ) -> Observable<Int> {
    return Single<Int>.create { [weak self] emitter in
      guard let self = self else {
        emitter(.failure(RxCocoaError.unknown))
        return Disposables.create()
      }
      
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      alert.modalPresentationStyle = .popover
      alert.popoverPresentationController?.permittedArrowDirections = .up
      alert.popoverPresentationController?.sourceView = sourceView.superview
      alert.popoverPresentationController?.sourceRect = CGRect(origin: sourceView.center, size: .zero)
      
      let firstAction = UIAlertAction(title: firstTitle, style: .default) { action in
        emitter(.success(0))
      }
      let secondAction = UIAlertAction(title: secondTitle, style: .default) { action in
        emitter(.success(1))
      }
      alert.addAction(firstAction)
      alert.addAction(secondAction)
      self.present(alert, animated: true)
      
      return Disposables.create {
        alert.dismiss(animated: true)
      }
    }.asObservable()
  }
  
  private func distinguishMenuType(of card: Card) -> (CardType, CardType) {
    switch card.cardType {
    case .todo: return (.doing, .done)
    case .doing: return (.todo, .done)
    case .done: return (.todo, .doing)
    }
  }
}
