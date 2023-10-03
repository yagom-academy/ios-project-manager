//
//  TaskViewController.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/03.
//

import UIKit

final class TaskViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Title"
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.delegate = self
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpConstraints()
        setUpViewController()
    }
    
    private func configureUI() {
        [titleTextField, datePicker, descriptionTextView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        descriptionTextView.setContentHuggingPriority(.init(1), for: .vertical)
    }
    
    private func setUpViewController() {
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = .init(systemItem: .cancel)
        navigationItem.rightBarButtonItem = .init(systemItem: .done)
    }
}

// MARK: - TextView Delegate
extension TaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}
