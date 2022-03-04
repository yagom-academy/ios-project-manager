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

class TaskViewController: UIViewController {
    
    weak var delegate: TodoAddDelegate?
    
    let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .bezel
        textField.adjustsFontForContentSizeCategory = true
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = emptyView
        textField.leftViewMode = .always
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title2)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.systemGray2.cgColor
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
    }
    
    func configureNavigationBar() {
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(addAction))
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "TODO"
    }
    
    @objc func addAction() {
        guard let title = titleTextField.text,
              let body = bodyTextView.text else {
            return
        }
        let deadline = datePicker.date
        let todo = Todo(title: title, deadline: deadline, body: body)
        
        delegate?.addTodo(data: todo)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureUI() {
        configureStackView()
        configureTextFieldLayout()
    }
    
    func configureStackView() {
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
    
    func configureTextFieldLayout() {
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalTo: entireStackView.heightAnchor, multiplier: 0.06)
        ])
    }
}
