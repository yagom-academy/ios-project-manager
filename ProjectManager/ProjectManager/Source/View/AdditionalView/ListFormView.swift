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
    
    private func addShadowEffect() {
        titleTextField.layer.shadowOffset = CGSize(width: 1, height: 5)
        titleTextField.layer.shadowOpacity = 0.3
        titleTextField.layer.shadowRadius = 5.0
        titleTextField.layer.shadowPath = UIBezierPath(
            roundedRect: titleTextField.bounds,
            cornerRadius: titleTextField.layer.cornerRadius
        ).cgPath
      
        bodyTextView.layer.shadowOffset = CGSize(width: 1, height: 5)
        bodyTextView.layer.shadowOpacity = 0.3
        bodyTextView.layer.shadowRadius = 5.0
        bodyTextView.layer.shadowPath = UIBezierPath(
            roundedRect: bodyTextView.bounds,
            cornerRadius: bodyTextView.layer.cornerRadius
        ).cgPath
    }
    
    func configureViews(using listItem: ListItem) {
        titleTextField.text = listItem.title
        dueDatePicker.date = listItem.dueDate
        bodyTextView.text = listItem.body
    }
}
