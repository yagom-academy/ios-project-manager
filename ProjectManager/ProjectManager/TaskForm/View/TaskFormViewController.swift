//
//  TaskFormViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import UIKit

class TaskFormViewController: UIViewController {
    private let viewModel: TaskFormViewModel
    
    private let stackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.backgroundColor = .white
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        return stackView
    }()
    
    private let textField = {
        let textField = UITextField()
        
        textField.backgroundColor = .white
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowRadius = 5.0
        
        return textField
    }()
    
    private let datePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let textView = {
        let textView = UITextView()
        
        textView.font = .preferredFont(forTextStyle: .body)
        textView.clipsToBounds = false
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowRadius = 5.0
        textView.textContainerInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        return textView
    }()
    
    init(task: Task? = nil) {
        self.viewModel = TaskFormViewModel(task: task)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        setupNavigationBar()
        setupStackView()
        setupStackViewConstraints()
        setupContents()
        setupContentsEditable()
    }
    
    private func setupNavigationBar() {
        let leftBarbutton = UIBarButtonItem(title: viewModel.leftBarButtonTitle,
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonAction))
        let rightBarbutton = UIBarButtonItem(title: viewModel.rightBarButtonTitle,
                                            style: .plain,
                                            target: self,
                                            action: #selector(rightBarButtonAction))

        navigationItem.title = viewModel.navigationTitle
        navigationItem.leftBarButtonItem = leftBarbutton
        navigationItem.rightBarButtonItem = rightBarbutton
    }
    
    @objc private func leftBarButtonAction() {
        if viewModel.isEditable {
            dismiss(animated: true)
            
            return
        }
        
        textField.isEnabled = !viewModel.isEditable
        datePicker.isEnabled = !viewModel.isEditable
        textView.isEditable = !viewModel.isEditable
    }
    
    @objc private func rightBarButtonAction() {
        viewModel.doneAction(title: textField.text ?? "",
                             date: datePicker.date,
                             body: textView.text ?? "")
        
        dismiss(animated: true)
    }
    
    private func setupStackViewConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
            
            textField.heightAnchor.constraint(equalTo: datePicker.heightAnchor, multiplier: 0.25)
        ])
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textView)
    }
    
    private func setupContents() {
        textField.text = viewModel.title
        datePicker.setDate(viewModel.deadline, animated: false)
        textView.text = viewModel.body
    }
    
    private func setupContentsEditable() {
        textField.isEnabled = viewModel.isEditable
        datePicker.isEnabled = viewModel.isEditable
        textView.isEditable = viewModel.isEditable
    }
}
