//
//  TodoDetailView.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/06.
//

import UIKit

final class TodoDetailView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        
        let paddingView: UIView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 20,
                height: textField.frame.height
            )
        )
        
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangeSubviews(titleTextField, datePicker, contentTextView)
    }
    
    private func setupConstraint() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
}
