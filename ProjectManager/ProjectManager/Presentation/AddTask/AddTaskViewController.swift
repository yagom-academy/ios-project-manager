//
//  AddTaskViewController.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

final class AddTaskViewController: UIViewController {
    
    // MARK: Subview
    let subject = PublishSubject<Task>()
    
    private var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    private var datePickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = Date()
        picker.maximumDate = .distantFuture
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    private var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureViewLayout()
    }
}

// MARK: Functions

extension AddTaskViewController {
    private func configureNavigationBar() {
        self.navigationItem.title = "TODO"
        self.navigationController?.navigationBar.backgroundColor = .systemGray3
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done,
                                          target: self, action: #selector(tapDoneButton))
        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self, action: #selector(tapCancelButton))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc
    private func tapCancelButton() {
        // TODO: Add action
        self.dismiss(animated: true)
    }
    
    @objc
    private func tapDoneButton() {
        // TODO: Add action
        let newTask = Task(title: titleTextView.text,
                           description: descriptionTextView.text,
                           expireDate: datePickerView.date,
                           tag: .todo)
        subject.onNext(newTask)
        self.dismiss(animated: true)
    }
}

// MARK: Layout

extension AddTaskViewController {
    private func configureViewLayout() {
        view.backgroundColor = .white
        view.addSubview(titleTextView)
        view.addSubview(datePickerView)
        view.addSubview(descriptionTextView)

        titleTextView.backgroundColor = .systemPink
        descriptionTextView.backgroundColor = .systemBrown
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: 10),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 10),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -10),
            titleTextView.heightAnchor.constraint(equalToConstant: 80),
            
            datePickerView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor,
                                                constant: 10),
            datePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 10),
            datePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -10),
            datePickerView.heightAnchor.constraint(equalToConstant: 180),
            
            descriptionTextView.topAnchor.constraint(equalTo: datePickerView.bottomAnchor,
                                                     constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                         constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                        constant: -10),
        ])
    }
}
