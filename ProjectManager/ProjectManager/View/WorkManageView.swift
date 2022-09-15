//
//  WorkManageView.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import UIKit

final class WorkManageView: UIView {
    // MARK: - Propertie
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        textField.applyShadow()
        return textField
    }()
    
    private let deadlinePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .systemBackground
        datePicker.locale = Locale(identifier: Locale.preferredLanguages.first ?? "ko")
        return datePicker
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        textView.applyShadow()
        return textView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        addSubView()
        setupConstraints()
        self.backgroundColor = .systemGray6
    }
    
    private func addSubView() {
        verticalStackView.addArrangedSubview(titleTextField)
        verticalStackView.addArrangedSubview(deadlinePicker)
        verticalStackView.addArrangedSubview(contentTextView)
        
        self.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.topAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            verticalStackView.bottomAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            contentTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        ])
    }
    
    func configure(with work: Work) {
        titleTextField.text = work.title
        contentTextView.text = work.content
        deadlinePicker.date = work.deadline
    }
    
    func createNewWork(id: UUID = UUID(), state: WorkState = .todo) -> Work? {
        guard let title = titleTextField.text,
              let content = contentTextView.text else { return nil }
        let deadline = deadlinePicker.date
        
        return Work(id: id, title: title, content: content, deadline: deadline, state: state)
    }
    
    func changeEditMode(_ isOn: Bool) {
        titleTextField.isEnabled = isOn
        contentTextView.isEditable = isOn
        deadlinePicker.isEnabled = isOn
    }
}
