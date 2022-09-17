//
//  FormSheetTemplateView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class FormSheetTemplateView: UIView {
    
    // MARK: - UIComponents
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 10,
                                               left: 10,
                                               bottom: 20,
                                               right: 10)
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.placeholder = "Title"
        textField.backgroundColor = .white
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.addLeftPadding()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray6.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowOpacity = 0.5
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.backgroundColor = .white
        textView.layer.masksToBounds = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.layer.shadowOpacity = 0.5
        return textView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleTextField)
        verticalStackView.addArrangedSubview(datePicker)
        verticalStackView.addArrangedSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            verticalStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            verticalStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            )
        ])
    }
    
    func setupData(with model: Todo?) {
        guard let model = model else { return }
        titleTextField.text = model.title
        datePicker.date = model.date
        bodyTextView.text = model.body
    }
    
    func generateTodoModel(with category: String) -> Todo? {
        guard let title = titleTextField.text,
                let body = bodyTextView.text else { return nil }
        let date = datePicker.date
        let todo = Todo()
        todo.category = category
        todo.title = title
        todo.body = body
        todo.date = date
        return todo
    }
}
