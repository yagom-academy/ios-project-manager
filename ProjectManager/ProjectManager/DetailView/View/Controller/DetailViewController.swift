//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//

import UIKit

final class DetailViewController: UIViewController {
    private let titleTextfield = {
        let textField = UITextField()
        return textField
    }()
    
    private let datePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let bodyTextView = {
        let textView = UITextView()
        return textView
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        configureStackView()
        configureRootView()
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(titleTextfield)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureRootView() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20)
        ])
    }
}
