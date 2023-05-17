//
//  TodoView.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit

final class TodoView: UIView {
    
    private let viewModel: TodoViewModel
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground
        
        return navigationBar
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 3.0
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: Locale.current.identifier)
        
        return datePicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        
        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3.0
        
        return textView
    }()
    
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        configureView()
        configureNavigationBar()
        configureStackView()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        
        self.addSubview(navigationBar)
        self.addSubview(stackView)
    }
   
    private func configureNavigationBar() {
        let title = "TODO"
        let done = "Done"
        let cancel = "Cancel"
        
        let doneButton = UIBarButtonItem(title: done, style: .done, target: self, action: #selector(doneButtonTapped))
        let cancelButton = UIBarButtonItem(title: cancel, style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        let navigationItem = UINavigationItem(title: title)
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationBar.items = [navigationItem]
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
                                         
    @objc private func doneButtonTapped() {
        viewModel.dismiss()
    }
    
    @objc private func cancelButtonTapped() {
        viewModel.dismiss()
    }

    private func configureStackView() {
        stackView.addArrangedSubview(titleField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
