//
//  CardAdditionViewController.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/07.
//

import UIKit

import RxSwift
import Then

final class CardAdditionViewController: UIViewController {
  private enum UISettings {
    static let navigationTitle = "TODO"
    static let titleTextFieldHeight = 48.0
    static let titleTextFieldLeftPadding = 10.0
    static let intervalFromSuperView = 16.0
    static let intervalBetweenForms = 16.0
    static let formsBorderWidth = 1.0
  }
  
  private enum Placeholders {
    static let titleTextField = "Title"
  }
  
  private let cancelAdditionButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
  private let doneAdditionButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
  private lazy var navigationBar = UINavigationBar().then {
    $0.items = [navigationItem]
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private let titleTextField = UITextField().then {
    let size = CGSize(width: UISettings.titleTextFieldLeftPadding, height: $0.frame.height)
    $0.leftView = UIView(frame: CGRect(origin: .zero, size: size))
    $0.leftViewMode = .always
    $0.font = .preferredFont(forTextStyle: .title3)
    $0.placeholder = Placeholders.titleTextField
    $0.layer.borderColor = UIColor.systemGray4.cgColor
    $0.layer.borderWidth = UISettings.formsBorderWidth
  }
  private let descriptionTextView = UITextView().then {
    $0.font = .preferredFont(forTextStyle: .body)
    $0.layer.borderWidth = UISettings.formsBorderWidth
    $0.layer.borderColor = UIColor.systemGray4.cgColor
  }
  private let deadlineDatePicker = UIDatePicker().then {
    $0.datePickerMode = .date
    $0.preferredDatePickerStyle = .wheels
    $0.layer.borderWidth = UISettings.formsBorderWidth
    $0.layer.borderColor = UIColor.systemGray4.cgColor
  }
  private let containerStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = UISettings.intervalBetweenForms
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private let viewModel: CardListViewModel
  private let disposeBag = DisposeBag()
  
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
    cancelAdditionButton.rx.tap
      .bind(onNext: { [weak self] in
        self?.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
    
    doneAdditionButton.rx.tap
      .bind(onNext: { [weak self] in
        guard let self = self else { return }
        
        let title = self.titleTextField.text
        let description = self.descriptionTextView.text
        let deadlineDate = self.deadlineDatePicker.date
        
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
    navigationItem.leftBarButtonItem = cancelAdditionButton
    navigationItem.rightBarButtonItem = doneAdditionButton
  }
  
  private func configureSubViews() {
    view.addSubview(navigationBar)
    view.addSubview(containerStackView)
    
    [titleTextField, deadlineDatePicker, descriptionTextView].forEach {
      containerStackView.addArrangedSubview($0)
    }
  }
  
  private func configureLayouts() {
    view.backgroundColor = .systemBackground
    
    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      titleTextField.heightAnchor.constraint(equalToConstant: UISettings.titleTextFieldHeight),
      containerStackView.topAnchor.constraint(
        equalTo: navigationBar.bottomAnchor,
        constant: UISettings.intervalFromSuperView
      ),
      containerStackView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
        constant: -UISettings.intervalFromSuperView
      ),
      containerStackView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
        constant: UISettings.intervalFromSuperView
      ),
      containerStackView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: -UISettings.intervalFromSuperView
      ),
    ])
  }
}
