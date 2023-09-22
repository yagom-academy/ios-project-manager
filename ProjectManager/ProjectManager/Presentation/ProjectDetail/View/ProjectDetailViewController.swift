//
//  ProjectDetailViewController.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/21.
//

import UIKit

final class ProjectDetailViewController: UIViewController {
    
    // MARK: - Private ProPerty
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.placeholder = "Title"
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.lightGray.cgColor
        
        return textView
    }()
    
    // MARK: - Life Cycle
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Configure UI
extension ProjectDetailViewController {
    private func configureUI() {
        configureNavigation()
        configureView()
        configureStackView()
        configureLayout()
    }
    
    private func configureNavigation() {
        navigationItem.title = "TODO"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemFill
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureView() {
        view.addSubview(stackView)
        view.backgroundColor = .systemBackground
    }
    
    private func configureStackView() {
        [textField, datePicker, textView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16)
        ])
    }
}
