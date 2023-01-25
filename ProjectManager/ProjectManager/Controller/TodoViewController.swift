//
//  AddTodoViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/16.
//

import UIKit

final class TodoViewController: UIViewController {
    private var todoItem: TodoModel?
    private var viewStatus: ViewStatus = .add
    
    private enum ViewStatus {
        case add
        case edit
    }
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private(set) var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = PlaceHolder.itemViewTitle
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.isEnabled = true
        return textField
    }()
    
    private(set) var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        
        let localeLanguage = Locale.preferredLanguages.first
        picker.locale = Locale(identifier: localeLanguage ?? DatePickerValue.locale)
        picker.timeZone = TimeZone(abbreviation: DatePickerValue.timezone)
        
        picker.isEnabled = true
        return picker
    }()
    
    private(set) var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = PlaceHolder.itemViewBody
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: .none)
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.isEditable = true
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigationBar()
        configureContentView()
    }
    
    func configureAddView(with todoItem: TodoModel) {
        viewStatus = .add
        isEditing = true
        self.todoItem = todoItem
    }
    
    func configureEditView(with todoItem: TodoModel) {
        viewStatus = .edit
        isEditing = false
        self.todoItem = todoItem
    }
    
    private func configureLayout() {
        mainStackView.addArrangedSubview(titleTextField)
        mainStackView.addArrangedSubview(datePicker)
        mainStackView.addArrangedSubview(bodyTextView)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = TodoViewTitle.navigationBar
        
        switch viewStatus {
        case .add:
            navigationItem.leftBarButtonItem =  configureCancelButton()
            navigationItem.rightBarButtonItem = configureDoneButton()
        case .edit:
            navigationItem.leftBarButtonItem = configureCancelButton()
            navigationItem.rightBarButtonItem = editButtonItem
        }
    }
    
    private func configureCancelButton() -> UIBarButtonItem {
        return UIBarButtonItem(title: TodoViewTitle.cancel,
                               style: .plain,
                               target: self,
                               action: #selector(tappedCancel))
    }
    
    @objc func tappedCancel() {
        dismiss(animated: true)
    }
    
    private func configureDoneButton() -> UIBarButtonItem {
        return UIBarButtonItem(title: TodoViewTitle.done,
                               style: .done,
                               target: self,
                               action: #selector(tappedDone))
    }
    
    @objc private func tappedDone() {
        guard var todoItem = todoItem else { return }
        
        todoItem.title = titleTextField.text ?? ""
        todoItem.body = bodyTextView.text ?? ""
        todoItem.date = datePicker.date.convertDateToDouble()
        
        switch viewStatus {
        case .add:
            MockDataManager.shared.create(todo: todoItem)
            dismiss(animated: true)
        case .edit:
            MockDataManager.shared.update(todo: todoItem, status: todoItem.status)
        }
    }
    
    private func configureContentView() {
        view.backgroundColor = .white
        
        guard let todoItem = self.todoItem else { return }
        
        titleTextField.text = todoItem.title
        bodyTextView.text = todoItem.body
        bodyTextView.delegate = self
        datePicker.date = todoItem.date.convertDoubleToDate()
    }
}

extension TodoViewController {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            navigationItem.rightBarButtonItem = configureDoneButton()
            titleTextField.layer.borderColor = UIColor.systemGray3.cgColor
            bodyTextView.layer.borderColor = UIColor.systemGray3.cgColor
            
            titleTextField.isEnabled = true
            datePicker.isEnabled = true
            bodyTextView.isEditable = true
        } else {
            titleTextField.layer.borderColor = UIColor.systemGray5.cgColor
            bodyTextView.layer.borderColor = UIColor.systemGray5.cgColor
            
            titleTextField.isEnabled = false
            datePicker.isEnabled = false
            bodyTextView.isEditable = false
        }
    }
}

extension TodoViewController: LimitableTextCount {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text,
              let range = Range(range, in: currentText) else {
            return false
        }
        
        let changedText = currentText.replacingCharacters(in: range, with: text)
        return changedText.count <= TodoItemValue.bodyLimit
    }
}
