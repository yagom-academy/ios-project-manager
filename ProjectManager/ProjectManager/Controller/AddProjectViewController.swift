//
//  ProjectManager - AddProjectViewController.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureContentStackView()
        configureConstraint()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 0.5)

        title = "TODO"
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                             target: self,
                                             action: #selector(editProject))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(doneEditingProject))
        navigationItem.leftBarButtonItem = editButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc
    private func editProject() {
        print("editProject")
    }
    
    @objc
    private func doneEditingProject() {
        print("doneEditingProject")
    }
    
    private func configureContentStackView() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleTextField)
        contentStackView.addArrangedSubview(datePicker)
        contentStackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bodyTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
