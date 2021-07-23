//
//  TaskFormViewController.swift
//  ProjectManager
//
//  Created by steven on 7/23/21.
//

import UIKit

enum FormType {
    case edit
    case add
}

class TaskFormViewController: UIViewController {
    var type: FormType = .edit {
        didSet {
            configureLeftBarButtonItem(type: type)
        }
    }
   
    init(type: FormType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        self.configureLeftBarButtonItem(type: type)
    }
    
    private func configureLeftBarButtonItem(type: FormType) {
        switch type {
        case .edit:
            self.view.isUserInteractionEnabled = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit",
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(editTask))
        case .add:
            self.view.isUserInteractionEnabled = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(clickLeftBarButton))
        }
//        let buttonTitle = type == .edit ? "Edit" : "Cancel"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.font = UIFont.preferredFont(forTextStyle: .title1)
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, datePicker, contentTextView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(clickRightBarButton))
        self.view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func editTask() {
        self.view.isUserInteractionEnabled = true
        //todo: 키보드 입력 후 datepicker 조정시 키보드가 내려가도록 설정
        self.titleTextField.becomeFirstResponder()
    }
    
    @objc private func clickLeftBarButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func clickRightBarButton() {
        guard let navigationViewController = self.presentingViewController as? UINavigationController,
              let viewController = navigationViewController.topViewController as? ViewController else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateText = dateFormatter.string(from: datePicker.date)
        
        let task = Task(title: titleTextField.text!, content: contentTextView.text!, deadLine: dateText, state: "todo")
        
        viewController.addNewTask(task)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureViews(_ task: Task) {
        titleTextField.text = task.title
        contentTextView.text = task.content
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        guard let date = dateFormatter.date(from: task.deadLine) else { return }
        datePicker.date = date
        navigationItem.title = task.state.uppercased()
    }
}
