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
    Observable.zip(
      todoSectionView.tableView.rx.itemSelected,
      todoSectionView.tableView.rx.modelSelected(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      guard let self = self else { return }
      self.todoSectionView.tableView.deselectRow(at: indexPath, animated: true)
      let cardDetailViewController = CardDetailViewController(viewModel: self.viewModel, card: card)
      cardDetailViewController.modalPresentationStyle = .formSheet
      self.present(cardDetailViewController, animated: true)
    })
    .disposed(by: disposeBag)
    
    Observable.zip(
      doingSectionView.tableView.rx.itemSelected,
      doingSectionView.tableView.rx.modelSelected(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      guard let self = self else { return }
      self.doingSectionView.tableView.deselectRow(at: indexPath, animated: true)
      let cardDetailViewController = CardDetailViewController(viewModel: self.viewModel, card: card)
      cardDetailViewController.modalPresentationStyle = .formSheet
      self.present(cardDetailViewController, animated: true)
    })
    .disposed(by: disposeBag)
    
    Observable.zip(
      doneSectionView.tableView.rx.itemSelected,
      doneSectionView.tableView.rx.modelSelected(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      guard let self = self else { return }
      self.doneSectionView.tableView.deselectRow(at: indexPath, animated: true)
      let cardDetailViewController = CardDetailViewController(viewModel: self.viewModel, card: card)
      cardDetailViewController.modalPresentationStyle = .formSheet
      self.present(cardDetailViewController, animated: true)
    })
    .disposed(by: disposeBag)
  }
  
  private func bindSectionsItemDeleted() {
    Observable.zip(
      todoSectionView.tableView.rx.itemDeleted,
      todoSectionView.tableView.rx.modelDeleted(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      self?.viewModel.deleteSelectedCard(card)
    })
    .disposed(by: disposeBag)
    
    Observable.zip(
      doingSectionView.tableView.rx.itemDeleted,
      doingSectionView.tableView.rx.modelDeleted(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      self?.viewModel.deleteSelectedCard(card)
    })
    .disposed(by: disposeBag)
    
    Observable.zip(
      doneSectionView.tableView.rx.itemDeleted,
      doneSectionView.tableView.rx.modelDeleted(Card.self)
    )
    .bind(onNext: { [weak self] indexPath, card in
      self?.viewModel.deleteSelectedCard(card)
    })
    .disposed(by: disposeBag)
  }
  
  private func bindSectionsLongPressed() {
    todoSectionView.tableView.rx.modelLongPressed(Card.self)
      .withUnretained(self)
      .flatMap { wself, item in wself.showPopover(cell: item.0, card: item.1) }
      .bind(onNext: { [weak self] card, cardType in
        self?.viewModel.moveDifferentSection(card, to: cardType)
      })
      .disposed(by: disposeBag)
    
    doingSectionView.tableView.rx.modelLongPressed(Card.self)
      .withUnretained(self)
      .flatMap { wself, item in wself.showPopover(cell: item.0, card: item.1) }
      .bind(onNext: { [weak self] card, cardType in
        self?.viewModel.moveDifferentSection(card, to: cardType)
      })
      .disposed(by: disposeBag)
    
    doneSectionView.tableView.rx.modelLongPressed(Card.self)
      .withUnretained(self)
      .flatMap { wself, item in wself.showPopover(cell: item.0, card: item.1) }
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
  private func showPopover(cell: UITableViewCell, card: Card) -> Observable<(Card, CardType)> {
    return Single<(Card, CardType)>.create { [weak self, weak cell] emitter in
      guard let self = self, let cell = cell else {
        emitter(.failure(RxCocoaError.unknown))
        return Disposables.create()
      }
      
      let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      alertController.popoverPresentationController?.permittedArrowDirections = .up
      alertController.popoverPresentationController?.sourceView = cell.superview
      alertController.popoverPresentationController?.sourceRect = CGRect(origin: cell.center, size: .zero)
      alertController.modalPresentationStyle = .popover
      
      let (firstCardType, secondCardType) = self.distinguishMenuType(of: card)
      
      let firstAction = UIAlertAction(
        title: firstCardType.moveToMenuTitle,
        style: .default
      ) { _ in
        emitter(.success((card, firstCardType)))
      }
      
      let secondAction = UIAlertAction(
        title: secondCardType.moveToMenuTitle,
        style: .default
      ) { _ in
        emitter(.success((card, secondCardType)))
      }
      
      alertController.addAction(firstAction)
      alertController.addAction(secondAction)
      self.present(alertController, animated: true)
      
      return Disposables.create {
        alertController.dismiss(animated: true)
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
