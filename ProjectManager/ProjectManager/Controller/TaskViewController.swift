//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by 권나영 on 2022/03/04.
//

import UIKit

protocol TodoAddDelegate: AnyObject {
    func addTodo(data: Todo)
}

final class TaskViewController: UIViewController {
    
    private let task: Task
    weak var delegate: TodoAddDelegate?
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .bezel
        textField.adjustsFontForContentSizeCategory = true
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = emptyView
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title2)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.systemGray2.cgColor
        return textView
    }()
    
    private lazy var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel",
                                     style: .plain,
                                     target: self,
                                     action: #selector(cancelAction))
        return button
    }()
    
    private lazy var editBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Edit",
                                     style: .plain,
                                     target: self,
                                     action: #selector(editAction))
        return button
    }()
    
    private lazy var doneBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Done",
                                     style: .done,
                                     target: self,
                                     action: #selector(addAction))
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureUI()
        registerDelegate()
    }
    
    init(task: Task, todo: Todo?) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
        
        setIntialValue(with: todo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setIntialValue(with todo: Todo?) {
        titleTextField.text = todo?.title
        bodyTextView.text = todo?.body
        datePicker.date = todo?.deadline ?? Date()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.leftBarButtonItem = task == .add ? cancelBarButton : editBarButton
        navigationItem.title = "TODO"
    }
    
    private func configureUI() {
        configureBackgroundColor()
        configureStackView()
        configureTextFieldLayout()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureStackView() {
        view.addSubview(entireStackView)
        entireStackView.addArrangedSubview(titleTextField)
        entireStackView.addArrangedSubview(datePicker)
        entireStackView.addArrangedSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            entireStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            entireStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            entireStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
    }
    
    private func configureTextFieldLayout() {
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalTo: entireStackView.heightAnchor, multiplier: 0.06)
        ])
    }
    
    private func registerDelegate() {
        bodyTextView.delegate = self
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if titleTextField.text == "" || bodyTextView.text == "" {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func editAction() {
        print("edit 기능 구현")
    }
    
    @objc private func addAction() {
        guard let title = titleTextField.text,
              let body = bodyTextView.text else {
                  return
              }
        let deadline = datePicker.date
        let todo = Todo(title: title, deadline: deadline, body: body)
        
        delegate?.addTodo(data: todo)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate

extension TaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if titleTextField.text == "" || bodyTextView.text == "" {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
    }
}
