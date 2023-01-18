//
//  EditorViewController.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/17.
//

import UIKit

class EditorViewController: UIViewController {
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.placeholder = "Title"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.layer.shadowColor = UIColor.systemGray.cgColor
        textField.layer.shadowOffset = CGSize(width: 2, height: 3)
        textField.layer.shadowOpacity = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .subheadline)
        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: 2, height: 3)
        textView.layer.shadowOpacity = 0.5
        return textView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
        configureNavigation()
    }
}

// MARK: Action Method
extension EditorViewController {
    private func tapCancelButton(_ sender: UIAction) {
        dismiss(animated: true)
    }
}

// MARK: UI Configuration
extension EditorViewController {
    private func configureView() {
        view.backgroundColor = .white
        
        [textField, datePicker, textView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8),
            
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .done,
            primaryAction: nil
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .cancel,
            primaryAction: UIAction(handler: tapCancelButton)
        )
    }
}
