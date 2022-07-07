//
//  CardEditView.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/08.
//

import UIKit

import Then

final class CardEditView: UIView {
  private enum UISettings {
    static let titleTextFieldHeight = 48.0
    static let titleTextFieldLeftPadding = 10.0
    static let intervalFromSuperView = 16.0
    static let intervalBetweenForms = 16.0
    static let formsBorderWidth = 1.0
  }
  
  private enum Placeholders {
    static let titleTextField = "Title"
  }
  
  let leftBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
  let rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
  
  let titleTextField = UITextField().then {
    let size = CGSize(width: UISettings.titleTextFieldLeftPadding, height: $0.frame.height)
    $0.leftView = UIView(frame: CGRect(origin: .zero, size: size))
    $0.leftViewMode = .always
    $0.font = .preferredFont(forTextStyle: .title3)
    $0.placeholder = Placeholders.titleTextField
    $0.layer.borderColor = UIColor.systemGray4.cgColor
    $0.layer.borderWidth = UISettings.formsBorderWidth
  }
  let descriptionTextView = UITextView().then {
    $0.font = .preferredFont(forTextStyle: .body)
    $0.layer.borderWidth = UISettings.formsBorderWidth
    $0.layer.borderColor = UIColor.systemGray4.cgColor
  }
  let deadlineDatePicker = UIDatePicker().then {
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
  
  init() {
    super.init(frame: .zero)
    configureSubViews()
    configureLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureSubViews() {
    addSubview(containerStackView)
    
    [titleTextField, deadlineDatePicker, descriptionTextView].forEach {
      containerStackView.addArrangedSubview($0)
    }
  }
  
  private func configureLayouts() {
    backgroundColor = .systemBackground
    translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleTextField.heightAnchor.constraint(
        equalToConstant: UISettings.titleTextFieldHeight
      ),
      containerStackView.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor,
        constant: UISettings.intervalFromSuperView
      ),
      containerStackView.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor,
        constant: -UISettings.intervalFromSuperView
      ),
      containerStackView.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor,
        constant: UISettings.intervalFromSuperView
      ),
      containerStackView.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor,
        constant: -UISettings.intervalFromSuperView
      ),
    ])
  }
}
