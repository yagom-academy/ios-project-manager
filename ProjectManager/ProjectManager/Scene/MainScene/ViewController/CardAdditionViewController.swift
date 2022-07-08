//
//  CardAdditionViewController.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/07.
//

import UIKit

import RxSwift

final class CardAdditionViewController: UIViewController {
  private enum UISettings {
    static let navigationTitle = "TODO"
    static let leftBarButtonTitle = "Cancel"
    static let rightBarButtonTitle = "Done"
  }
  
  private let cardEditView = CardEditView()
  private let disposeBag = DisposeBag()
  private let viewModel: CardListViewModel
  
  init(viewModel: CardListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    configureSubViews()
    configureLayouts()
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
    cardEditView.leftBarButton.rx.tap
      .bind(onNext: { [weak self] in
        self?.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
    
    cardEditView.rightBarButton.rx.tap
      .bind(onNext: { [weak self] in
        guard let self = self else { return }
        
        let title = self.cardEditView.titleTextField.text
        let description = self.cardEditView.descriptionTextView.text
        let deadlineDate = self.cardEditView.deadlineDatePicker.date
        
        self.viewModel.createNewCard(title: title, description: description, deadlineDate: deadlineDate)
        self.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - UI Configuration

extension CardAdditionViewController {
  private func configureNavigationItem() {
    title = UISettings.navigationTitle
    navigationItem.leftBarButtonItem = cardEditView.leftBarButton
    navigationItem.rightBarButtonItem = cardEditView.rightBarButton
    
    cardEditView.navigationBar.items = [navigationItem]
    cardEditView.leftBarButton.title = UISettings.leftBarButtonTitle
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
