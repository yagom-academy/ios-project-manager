//
//  EditorViewController.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/17.
//

import UIKit

final class EditorViewController: UIViewController {
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
    
    private let viewModel: MainViewModelProtocol
    
    init(state: State, viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = state.name
    }
    
    convenience init(project: Project, viewModel: MainViewModelProtocol) {
        self.init(state: project.state, viewModel: viewModel)
        textField.text = project.title
        textView.text = project.description
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
    
    private func tapDoneButton(_ sender: UIAction) {
        guard let title = textField.text,
              let description = textView.text
        else {
            return
        }
        
        viewModel.createProject(title: title, deadline: datePicker.date, description: description)
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
            primaryAction: UIAction(handler: tapDoneButton)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .cancel,
            primaryAction: UIAction(handler: tapCancelButton)
        )
    }
}
