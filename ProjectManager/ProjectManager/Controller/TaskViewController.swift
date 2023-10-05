//
//  TaskViewController.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/03.
//

import UIKit

protocol TaskViewControllerDelegate: AnyObject {
    func didTappedRightDoneButton(task: Task)
}

final class TaskViewController: UIViewController {
    weak var  delegate: TaskViewControllerDelegate?
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 0.3
        textField.layer.shadowColor = UIColor.systemGray.cgColor
        textField.layer.shadowOffset = CGSize(width: 2, height: 3)
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 3
        textField.placeholder = "Title"
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: 2, height: 3)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3
        textView.layer.masksToBounds = false
        textView.delegate = self
        return textView
    }()
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        
        label.text = "여기는 할일 내용 입력하는 곳이지롱\n입력 가능한 글자수는 1000자로 제한합니다"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var task: Task
    
    init(task: Task) {
        self.task = task
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpConstraints()
        setUpViewController()
    }
    
    private func configureUI() {
        [titleTextField, datePicker, descriptionTextView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [stackView, placeHolderLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            placeHolderLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 5),
            placeHolderLabel.trailingAnchor.constraint(equalTo: descriptionTextView.trailingAnchor, constant: -5),
            placeHolderLabel.topAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: 5),
        ])
        
        descriptionTextView.setContentHuggingPriority(.init(1), for: .vertical)
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "TODO"
        
        let leftCancelButtonAction: UIAction = .init { action in
            self.didTappedLeftCancelButton()
        }
        
        let rightDoneButtonAction: UIAction = .init { action in
            self.didTappedRightDoneButton()
        }
        
        navigationItem.leftBarButtonItem = .init(systemItem: .cancel, primaryAction: leftCancelButtonAction)
        navigationItem.rightBarButtonItem = .init(systemItem: .done, primaryAction: rightDoneButtonAction)
    }
}

// MARK: - TextView Delegate
extension TaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            placeHolderLabel.isHidden = false
        }
    }
}

// MARK: - Button Action
extension TaskViewController {
    private func didTappedLeftCancelButton() {
        dismiss(animated: true)
    }
    
    private func didTappedRightDoneButton() {
        guard let title = titleTextField.text else { return }
        
        task.title = title
        task.description = descriptionTextView.text
        task.deadline = "123213123123123"
        delegate?.didTappedRightDoneButton(task: task)
        dismiss(animated: true)
    }
}
