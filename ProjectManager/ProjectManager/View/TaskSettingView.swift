//
//  TaskSettingView.swift
//  ProjectManager
//
//  Created by jin on 1/25/23.
//

import UIKit

class TaskSettingView: UIView {

    enum Constant {
        static let datePickerWidth: CGFloat = 400
        static let navigationTitle = "TODO"
        static let titleTextFieldPlaceHolder = "Title"
        static let stackViewSpacing: CGFloat = 10
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleTextField = {
        let textField = UITextField()
        textField.placeholder = Constant.titleTextFieldPlaceHolder
        textField.layer.cornerRadius = 2
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let datePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 2
        textView.layer.borderColor = UIColor.systemGray2.cgColor
        textView.layer.borderWidth = 1
        textView.translatesAutoresizingMaskIntoConstraints = false
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
        self.addSubview(stackView)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(descriptionTextView)
        configureDatePicker()
        configureContraints()
    }
    
    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.timeZone = .current
    }

    private func configureContraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constant.stackViewSpacing),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.stackViewSpacing),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constant.stackViewSpacing),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.stackViewSpacing)
        ])
    }
    
    func configureTaskData(with task: Task) {
        titleTextField.text = task.title
        descriptionTextView.text = task.description
        datePicker.date = task.date
    }
    
    func fetchTask() -> Task? {
        guard let title = titleTextField.text,
              title != ""
        else {
            return nil
        }
        guard let description = descriptionTextView.text,
            description != ""
        else {
            return nil
        }
        
        return Task(id: UUID(), title: title, description: description, date: datePicker.date, status: .todo)
    }
}
