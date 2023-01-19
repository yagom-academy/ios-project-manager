//
//  TodoItemView.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/14.
//

import UIKit

final class TodoItemView: UIView {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private(set) var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = PlaceHolder.itemViewtitle
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        return textField
    }()
    
    private(set) var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        
        let localeLanguage = Locale.preferredLanguages.first
        picker.locale = Locale(identifier: localeLanguage ?? DatePickerValue.locale)
        picker.timeZone = TimeZone(abbreviation: DatePickerValue.timezone)
        return picker
    }()
    
    private(set) var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = PlaceHolder.itemViewBody
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: .none)
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        mainStackView.addArrangedSubview(titleTextField)
        mainStackView.addArrangedSubview(datePicker)
        mainStackView.addArrangedSubview(bodyTextView)
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func updateContent(title: String, body: String, date: Date) {
        titleTextField.text = title
        bodyTextView.text = body
        datePicker.date = date
    }
}
