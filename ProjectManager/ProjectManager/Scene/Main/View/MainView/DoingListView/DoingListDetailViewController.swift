//
//  DoingListDetailViewController.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/10.
//

import UIKit

final class DoingListDetailViewController: UIViewController {
    
    // MARK: - Properties

    private let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5.0
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.8
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5.0
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.8
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private let titleTextView: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()
    
    private var timeLimitDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date

        return datePicker
    }()

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupSubviews()
        setupStackViewLayout()
    }

    // MARK: - Functions

    func loadData(of item: ToDoItem) {
        titleTextView.text = item.title
        timeLimitDatePicker.setDate(item.timeLimit, animated: true)
        descriptionTextView.text = item.description
    }
    
    private func setupSubviews() {
        titleView.addSubview(titleTextView)
        descriptionView.addSubview(descriptionTextView)
        
        [titleView, timeLimitDatePicker, descriptionView]
            .forEach { view.addSubview($0) }
    }
    
    private func setupStackViewLayout() {
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleView.bottomAnchor.constraint(equalTo: timeLimitDatePicker.topAnchor, constant: -20),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 20),
            titleTextView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -20),
            titleTextView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 20),
            titleTextView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            timeLimitDatePicker.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            timeLimitDatePicker.bottomAnchor.constraint(equalTo: descriptionView.topAnchor, constant: -20),
            timeLimitDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            timeLimitDatePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: timeLimitDatePicker.bottomAnchor, constant: 20),
            descriptionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            descriptionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 20),
            descriptionTextView.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -20),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -20)
        ])
    }
}
