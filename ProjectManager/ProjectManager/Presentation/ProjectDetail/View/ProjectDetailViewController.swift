//
//  ProjectDetailViewController.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/21.
//

import UIKit
import Combine

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
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.lightGray.cgColor
        
        return textView
    }()
    
    private let viewModel: ProjectDetailViewModel
    
    private var cancellables: [AnyCancellable] = []
    
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
        setupBindings()
    }
    
    @objc private func tapDoneButton() {
        viewModel.tapDoneButton(title: textField.text, body: textView.text, date: datePicker.date)
        
        dismiss(animated: true)
    }
    
    @objc private func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func tapEditButton() {
        viewModel.tapEditButton()
    }
    
    // MARK: - Data Binding
    private func setupBindings() {
        textField.text = viewModel.title
        textView.text = viewModel.body
        datePicker.date = viewModel.deadlineDate
        
        viewModel.isEditingPublisher.sink { [weak self] isEditing in
            guard let self else {
                return
            }
            
            self.configureViewObjectInput(isEditing)
        }.store(in: &cancellables)
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
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancelButton))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEditButton))
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemFill
        
        navigationItem.title = viewModel.navigationTitle
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = viewModel.hasProject ? editButton : cancelButton
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
    
    private func configureViewObjectInput(_ isInput: Bool) {
        textField.isEnabled = isInput
        textView.isEditable = isInput
        datePicker.isEnabled = isInput
    }
}
