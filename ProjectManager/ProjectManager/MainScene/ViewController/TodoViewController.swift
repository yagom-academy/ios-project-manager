//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/18.
//

import UIKit

final class TodoViewController: UIViewController {
    
    private let titleTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let descriptionTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationViewUI()
        configureViewUI()
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapDoneButton() {
        self.dismiss(animated: true)
    }
}

// MARK: UI
extension TodoViewController {
    private func configureNavigationViewUI() {
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(didTapDoneButton))
    }
    
    private func configureViewUI() {
        view.backgroundColor = .systemGray5
        
        configureTextFieldUI()
        configureDatePickerUI()
        configureTextViewUI()
        
        let mainStackView = UIStackView(arrangedSubviews: [titleTextField, datePicker, descriptionTextView])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.alignment = .center
        mainStackView.backgroundColor = .systemBackground
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            datePicker.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
    
    private func configureTextFieldUI() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.borderStyle = .bezel
        titleTextField.placeholder = "Title"
    }
    
    private func configureDatePickerUI() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
    }
    
    private func configureTextViewUI() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    }
}
