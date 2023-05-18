//
//  ToDoWriteViewController.swift
//  ProjectManager
//
//  Created by goat on 2023/05/18.
//

import UIKit

class ToDoWriteViewController: UIViewController {
    
    private let fullStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.placeholder = "내용을 입력하세요"
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en_US")
        return datePicker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: NavigationBar
    private func configureNavigationBar() {
        navigationItem.title = "TODO"
        let cancelButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let doneButton = UIBarButtonItem(title: "done" , style: .plain, target: self, action: #selector(doneButtonTapped))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func doneButtonTapped() {
        let toDoWriteViewController = ToDoWriteViewController()
        toDoWriteViewController.modalPresentationStyle = .formSheet
        self.present(toDoWriteViewController, animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    // MARK: Autolayout
    private func configureViewUI() {
        view.backgroundColor = .white
        view.addSubview(fullStackView)
        
        fullStackView.addArrangedSubview(titleTextField)
        fullStackView.addArrangedSubview(datePicker)
        fullStackView.addArrangedSubview(descriptionTextView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            fullStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            fullStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            fullStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            fullStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
