//
//  ProjectViewController.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import UIKit

final class ProjectViewController: UIViewController {
    
    // MARK: - properties
    
    private let projectTitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = Design.projectTitlePlaceholder
        textField.addLeftPadding()
        
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        
        return datePicker
    }()
    
    private let projectDescription: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        
        return textView
    }()
    
    private let projectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupNavigationItem()
    }
}

// MARK: - functions

extension ProjectViewController {
    private func setupStackView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(projectStackView)
        
        projectStackView.addArrangedSubview(projectTitle)
        projectStackView.addArrangedSubview(datePicker)
        projectStackView.addArrangedSubview(projectDescription)
        
        NSLayoutConstraint.activate([
            projectStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:  -4),
            projectStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            projectStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4)
        ])
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Todo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelButtonDidTapped))
    }
}

// MARK: - objc functions

extension ProjectViewController {
    @objc private func cancelButtonDidTapped() {
        // TodoListVC로 데이터 전송
        dismiss(animated: true)
    }
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
}
