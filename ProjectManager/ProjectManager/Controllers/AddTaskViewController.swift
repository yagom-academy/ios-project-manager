//
//  AddTaskViewController.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/20.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    enum Mode {
        case add
        case edit
    }
    
    enum EdgeInsert {
        static let descriptionContent = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    var taskDelegate: TaskAddDelegate?
    var mode: Mode?
    var currentData: Task?
    private var todoTitle: String?
    private var todoDescription: String?
    private let titleTextField: UITextField = {
        let title = UITextField(frame: .zero)
        title.placeholder = "Write Title ..."
        title.borderStyle = UITextField.BorderStyle.roundedRect
        title.backgroundColor = UIColor.white
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        title.layer.shadowOpacity = 1
        title.layer.shadowRadius = 4.0
        title.layer.shadowColor = UIColor.black.cgColor
        title.translatesAutoresizingMaskIntoConstraints = false
        title.autocorrectionType = .no
        return title
    }()
    private let datePickerView: UIDatePicker = {
        let date = UIDatePicker(frame: .zero)
        date.preferredDatePickerStyle = .wheels
        date.datePickerMode = .date
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    private let descriptionTextView: UITextView = {
        let description = UITextView(frame: .zero)
        description.clipsToBounds = false
        description.layer.cornerRadius = 20
        description.layer.shadowOpacity = 0.8
        description.layer.shadowOffset = CGSize(width: description.frame.width, height: description.frame.height)
        description.font = UIFont.preferredFont(forTextStyle: .subheadline)
        description.contentInset = EdgeInsert.descriptionContent
        description.translatesAutoresizingMaskIntoConstraints = false
        description.autocorrectionType = .no
        return description
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "TODO"
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        setNavigationItem()
        titleTextFieldConstraint()
        datePickerViewConstraint()
        descriptionTextViewConstraint()
        tapGestureAtKeyboardAnyWhere()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.text = nil
        descriptionTextView.text = nil
        todoTitle = nil
        todoDescription = nil
        datePickerView.setDate(Date(), animated: true)
        checkMode()
    }
    
    private func checkMode() {
        if mode == .edit {
            titleTextField.text = currentData?.taskTitle
            titleTextField.isEnabled = false
            descriptionTextView.text = currentData?.taskDescription
            descriptionTextView.isEditable = false
            datePickerView.setDate(currentData?.taskDeadline ?? Date(), animated: true)
            datePickerView.isEnabled = false
        }
    }
    
    private func setNavigationItem() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pushCloseButton))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(pushEditButton))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pushDoneButton))
        self.navigationItem.leftBarButtonItem = closeButton
        if let _ = mode {
            self.navigationItem.leftBarButtonItem = editButton
        }
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    private func tapGestureAtKeyboardAnyWhere() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func pushEditButton() {
        
    }
    
    @objc private func pushCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func pushDoneButton() {
        dismiss(animated: true) {
            // TODO Cell index 0에 추가
            guard let todoTitle = self.todoTitle else {
                // Alert title is empty
                return
            }
            
            guard let todoDescription = self.todoDescription else {
                // Alert description is empty
                return
            }
            
            let data = Task(taskTitle: todoTitle, taskDescription: todoDescription, taskDeadline: self.datePickerView.date)
            self.taskDelegate?.addData(data)
        }
    }
    
    private func titleTextFieldConstraint() {
        self.view.addSubview(titleTextField)
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            titleTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/16)
        ])
    }
    
    private func datePickerViewConstraint() {
        self.view.addSubview(datePickerView)
        NSLayoutConstraint.activate([
            datePickerView.centerXAnchor.constraint(equalTo: titleTextField.centerXAnchor),
            datePickerView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 25),
            datePickerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/5),
            datePickerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2)
        ])
    }
    
    private func descriptionTextViewConstraint() {
        self.view.addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.centerXAnchor.constraint(equalTo: datePickerView.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 25),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // titleTextField value
        guard let text = textField.text else { return }
        todoTitle = text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        todoDescription = text
    }
}
