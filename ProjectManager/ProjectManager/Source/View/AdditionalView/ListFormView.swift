//
//  ListFormView.swift
//  ProjectManager
//  Created by inho on 2023/01/15.
//

import UIKit

class ListFormView: UIStackView {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .headline)
        
        return textField
    }()
    private let dueDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "입력 가능한 글자수는 1000자로 제한합니다."
        textView.font = .systemFont(ofSize: UIFont.systemFontSize)
        
        return textView
    }()
    var currentTitle: String {
        return titleTextField.text ?? String()
    }
    var currentDate: Date {
        return dueDatePicker.date
    }
    var currentBody: String {
        return bodyTextView.text
    }
    
    init(listItem: ListItem? = nil) {
        super.init(frame: .zero)
        
        if let item = listItem {
            titleTextField.text = item.title
            bodyTextView.text = item.body
        }
        
        setupStackView()
        configureLayout()
        addBorderToTextInputViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        translatesAutoresizingMaskIntoConstraints = false
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 5, left: 10, bottom: 20, right: 10)
        axis = .vertical
        spacing = 10
    }
    
    private func configureLayout() {
        [titleTextField, dueDatePicker, bodyTextView].forEach(addArrangedSubview(_:))
    }
    
    private func addBorderToTextInputViews() {
        titleTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        titleTextField.leftViewMode = .always
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor.systemGray.cgColor
        titleTextField.layer.cornerRadius = 5
        
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.borderColor = UIColor.systemGray.cgColor
        bodyTextView.layer.cornerRadius = 5
    }
    
    func configureTextViewDelegate(_ delegate: UITextViewDelegate) {
        bodyTextView.delegate = delegate
    }
    
    func configureViews(using listItem: ListItem) {
        titleTextField.text = listItem.title
        dueDatePicker.date = listItem.dueDate
        bodyTextView.text = listItem.body
    }
    
    func toggleViewsEnabledStatus() {
        titleTextField.isEnabled.toggle()
        dueDatePicker.isEnabled.toggle()
        bodyTextView.isEditable.toggle()
    }
}
