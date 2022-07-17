//
//  WriteView.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/11.
//

import UIKit

final class WriteTodoView: UIView {
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    //stackView.alignment = .center
    stackView.backgroundColor = .systemBackground
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let titleTextField: UITextField = {
    let textfield = UITextField()
    textfield.placeholder = "Title"
    textfield.textAlignment = .left
    textfield.font = .preferredFont(forTextStyle: .title1)
    textfield.layer.shadowOpacity = 0.5
    textfield.borderStyle = .line
    textfield.backgroundColor = .systemBackground
    return textfield
  }()
  
  let datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.locale = Locale(identifier: "en_US")
    datePicker.datePickerMode = .date
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.backgroundColor = UIColor.white
    datePicker.backgroundColor = .systemBackground
    return datePicker
  }()
  
  let contentTextView: UITextView = {
    let textView = UITextView()
    textView.font = .preferredFont(forTextStyle: .title1)
    textView.layer.shadowOpacity = 0.5
    textView.backgroundColor = .systemBackground
    textView.layer.shadowOpacity = 0.5
    textView.layer.borderWidth = 1
    textView.layer.borderColor = UIColor.black.cgColor
    return textView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    setContraints()
    backgroundColor = .systemBackground
    layer.cornerRadius = 20
  }
  
  private func setContraints() {
    addSubview(mainStackView)
    mainStackView.addArrangedSubviews([titleTextField, datePicker, contentTextView])
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
    ])
  }
  
  func setUserInteractionEnableViews(_ bool: Bool) {
    titleTextField.isUserInteractionEnabled = bool
    datePicker.isUserInteractionEnabled = bool
    contentTextView.isUserInteractionEnabled = bool
  }
  
  func updateTodoData(_ todo: Todo) {
    titleTextField.text = todo.title
    datePicker.date = todo.date
    contentTextView.text = todo.content
  }
}
