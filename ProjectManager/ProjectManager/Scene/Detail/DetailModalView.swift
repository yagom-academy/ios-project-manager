//
//  DetailModalView.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

final class DetailModalView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConsantrait()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleTextField, datePicker, bodyTextView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    
    private func setConsantrait() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setLabel(task: Task) {
        titleTextField.text = task.title
        bodyTextView.text = task.body
        datePicker.date = task.date
    }
}
