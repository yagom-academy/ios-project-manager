//
//  NewTodoFormViewController.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/05.
//

import UIKit

class NewTodoFormViewController: UIViewController {

    let newTodoFormStackView = NewTodoFormStackView()
    let newTodoFormTextField = NewTodoFormTextField()
    let datePicker = UIDatePicker()
    let newTodoFormTextView = NewTodoFormTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        configiureNewTodoFormStackView()
        configureNewTodoFormTextField()
        configureDatePicker()
        configureNewTodoFormTextView()
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureNewTodoFormTextField() {
        datePicker.preferredDatePickerStyle = .wheels
        newTodoFormStackView.addArrangedSubview(newTodoFormTextField)

        NSLayoutConstraint.activate([
            newTodoFormTextField.heightAnchor.constraint(equalToConstant: 50),
            newTodoFormTextField.topAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.topAnchor, constant: 10),
            newTodoFormTextField.leadingAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.leadingAnchor, constant: 10),
            newTodoFormTextField.trailingAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureDatePicker() {
        newTodoFormStackView.addArrangedSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: newTodoFormTextField.safeAreaLayoutGuide.bottomAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureNewTodoFormTextView() {
        newTodoFormStackView.addArrangedSubview(newTodoFormTextView)
        
        NSLayoutConstraint.activate([
            newTodoFormTextView.topAnchor.constraint(equalTo: datePicker.safeAreaLayoutGuide.bottomAnchor),
            newTodoFormTextView.leadingAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.leadingAnchor, constant: 10),
            newTodoFormTextView.trailingAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.trailingAnchor, constant: -10),
            newTodoFormTextView.bottomAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.bottomAnchor, constant: -25)
        ])
    }
    
    private func configiureNewTodoFormStackView() {
        view.addSubview(newTodoFormStackView)
        
        NSLayoutConstraint.activate([
            newTodoFormStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newTodoFormStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newTodoFormStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newTodoFormStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
