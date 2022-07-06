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
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: CGRect(x: .zero, y: .zero, width: bounds.width, height: 50))
        navigationBar.items = [navigationBarItem]
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        return navigationBar
    }()
    
    let navigationBarItem: UINavigationItem = {
        let navigationBarItem = UINavigationItem(title: "")
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        
        navigationBarItem.leftBarButtonItem = cancelItem
        navigationBarItem.rightBarButtonItem = doneItem
        return navigationBarItem
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
        addSubview(navigationBar)
        addSubview(stackView)
        stackView.addArrangeSubviews(navigationBar, titleTextField, datePicker, contentTextView)
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
