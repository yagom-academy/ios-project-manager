//
//  ProjectDetailViewController.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/21.
//

import UIKit

class ProjectDetailViewController: UIViewController {
    
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
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.placeholder = "Title"
        
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.lightGray.cgColor
        
        return textView
    }()
    
    let viewModel: ProjectDetailViewModel
    
    // MARK: - Life Cycle
    init(viewModel: ProjectDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View event
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @objc func tapDoneButton() {
        viewModel.tapDoneButton(title: textField.text, body: textView.text, date: datePicker.date)
        
        dismiss(animated: true)
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
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemFill
        
        navigationItem.title = viewModel.navigationTitle
        navigationItem.rightBarButtonItem = doneButton
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
