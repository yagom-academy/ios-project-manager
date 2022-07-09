//
//  CardDetailViewController.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/08.
//

import UIKit

import RxSwift

final class CardDetailViewController: UIViewController {
  private enum UISettings {
    static let navigationTitle = "TODO"
    static let leftBarButtonEditTitle = "Edit"
    static let leftBarButtonEditingTitle = "Editing"
    static let rightBarButtonTitle = "Done"
  }
  
  private let cardEditView = CardEditView()
  private var isEditable = false
  
  private let disposeBag = DisposeBag()
  private let viewModel: CardListViewModel
  private let card: Card
  
  init(viewModel: CardListViewModel, card: Card) {
    self.viewModel = viewModel
    self.card = card
    super.init(nibName: nil, bundle: nil)
    configureSubViews()
    configureLayouts()
    configureNavigationItem()
    configureCardEditView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindUI()
  }
  
  private func bindUI() {
    cardEditView.leftBarButton.rx.tap
      .bind(onNext: { [weak self] in
        self?.toggleEditingMode()
      })
      .disposed(by: disposeBag)
    
    cardEditView.rightBarButton.rx.tap
      .bind(onNext: { [weak self] in
        guard let self = self else { return }
        guard let card = self.updateSelectedCard() else { return }
        
        self.viewModel.updateSelectedCard(card)
        self.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
  }
  
  private func toggleEditingMode() {
    isEditable.toggle()
    cardEditView.titleTextField.isUserInteractionEnabled.toggle()
    cardEditView.descriptionTextView.isEditable.toggle()
    cardEditView.deadlineDatePicker.isUserInteractionEnabled.toggle()
    
    let title = isEditable ? UISettings.leftBarButtonEditingTitle : UISettings.leftBarButtonEditTitle
    cardEditView.leftBarButton.title = title
  }
  
  private func updateSelectedCard() -> Card? {
    guard let title = cardEditView.titleTextField.text,
          let description = cardEditView.descriptionTextView.text else { return nil }
    let deadlineDate = cardEditView.deadlineDatePicker.date
    
    var card = self.card
    card.title = title
    card.description = description
    card.deadlineDate = deadlineDate
    
    return card
  }
}

// MARK: - UI Configuration

extension CardDetailViewController {
  private func configureCardEditView() {
    cardEditView.titleTextField.text = card.title
    cardEditView.descriptionTextView.text = card.description
    cardEditView.deadlineDatePicker.date = card.deadlineDate
    cardEditView.titleTextField.isUserInteractionEnabled = false
    cardEditView.descriptionTextView.isEditable = false
    cardEditView.deadlineDatePicker.isUserInteractionEnabled = false
  }
  
  private func configureNavigationItem() {
    title = UISettings.navigationTitle
    navigationItem.leftBarButtonItem = cardEditView.leftBarButton
    navigationItem.rightBarButtonItem = cardEditView.rightBarButton
    
    cardEditView.navigationBar.items = [navigationItem]
    cardEditView.leftBarButton.title = UISettings.leftBarButtonEditTitle
    cardEditView.rightBarButton.title = UISettings.rightBarButtonTitle
    cardEditView.rightBarButton.style = .done
  }
  
  private func configureSubViews() {
    view.addSubview(cardEditView)
  }
  
  private func configureLayouts() {
    view.backgroundColor = .systemBackground
    
    NSLayoutConstraint.activate([
      cardEditView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      cardEditView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      cardEditView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      cardEditView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
}
