//
//  NewTODOViewController.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/22.
//

import UIKit

final class NewTODOViewController: UIViewController {
    private let datePicker: UIDatePicker = UIDatePicker()
    
    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
    }

    
    private let titleTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Title"
        textField.text = "텍스트필드"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .green
        
        return textField
    }()
    
    private let bodyTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.backgroundColor = .brown
        textView.text = "텍스트뷰"
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        configureDatePicker()
        configureLayout()
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        bodyTextView.delegate = self
        view.addSubview(titleTextField)
        view.addSubview(datePicker)
        view.addSubview(bodyTextView)
    }
    
    private func configureNavigation() {
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedEditButton))
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tappedDoneButton))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "여기에 제목불러오기"
    }
    
    @objc private func tappedEditButton() {
        
    }
    
    @objc private func tappedDoneButton() {
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 64),
            
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
            bodyTextView.heightAnchor.constraint(equalToConstant: 300),
            bodyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bodyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

extension NewTODOViewController: UITextViewDelegate {
    
}


