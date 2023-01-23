//
//  ModalViewContoller.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/13.
//

import UIKit

final class ModalViewContoller: UIViewController {
    private let data: TodoModel?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.backgroundColor = .systemBackground
        
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.shadowColor = UIColor.systemPink.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOffset = CGSize(width: 2, height: 4)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.5
        
        return textField
    }()
    
    private let deadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title3)
        
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.shadowColor = UIColor.systemPink.cgColor
        textView.layer.masksToBounds = false
        textView.layer.shadowOffset = CGSize(width: 2, height: 4)
        textView.layer.shadowRadius = 3
        textView.layer.shadowOpacity = 0.5
        
        return textView
    }()
    
    init(model: TodoModel? = nil) {
        self.data = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        configureLayout()
        setNavigation()
        setData()
    }
}

// MARK: - Business Logic
extension ModalViewContoller {
    private func configureLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        bodyTextView.delegate = self
        
        [titleTextField, deadlineDatePicker, bodyTextView].forEach { contents in
            self.view.addSubview(contents)
            contents.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            
            deadlineDatePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor),
            deadlineDatePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            deadlineDatePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            
            bodyTextView.topAnchor.constraint(equalTo: deadlineDatePicker.bottomAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            bodyTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            bodyTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8)
        ])
    }
    
    private func editMode(is input: Bool) {
        titleTextField.isEnabled = input
        deadlineDatePicker.isEnabled = input
        navigationItem.rightBarButtonItem?.isEnabled = input
    }
    
    private func setData() {
        guard let data = data,
              let todoDate = data.todoDate else { return }
        
        titleTextField.text = data.title
        deadlineDatePicker.date = todoDate
        bodyTextView.text = data.body
    }
    
    private func setNavigation() {
        navigationItem.title = "TODO"
        
        if data == nil {
            let leftBarButton = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(tapCancelButton)
            )
            navigationItem.leftBarButtonItem = leftBarButton
            
            let rightBarButton = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(tapDoneButton)
            )
            navigationItem.rightBarButtonItem = rightBarButton
            
            return
        }
        
        let leftBarButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(tapEditButton)
        )
        navigationItem.leftBarButtonItem = leftBarButton
        let rightBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(tapDoneButton)
        )
        navigationItem.rightBarButtonItem = rightBarButton
        editMode(is: false)
    }
}

// MARK: - objc Logic
extension ModalViewContoller {
    @objc private func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func tapEditButton() {
        if navigationItem.leftBarButtonItem?.title == "Cancel" {
            dismiss(animated: true)
        }
        
        editMode(is: true)
        navigationItem.leftBarButtonItem?.title = "Cancel"
    }
    
    @objc private func tapDoneButton() {
        guard let title = titleTextField.text else { return }
        guard let body = bodyTextView.text else { return }
        
        if let data = data {
            let state = data.state
            guard let state = State(rawValue: state) else { return }
            guard let id = data.id else { return }
            
            CoreDataManager.shared.updateData(
                title: title,
                body: body,
                todoDate: deadlineDatePicker.date,
                id: id,
                state: state
            )
        } else {
            CoreDataManager.shared.saveData(title: title, body: body, todoDate: deadlineDatePicker.date)
        }
        
        let notification = Notification.Name("DismissForReload")
        NotificationCenter.default.post(name: notification, object: nil, userInfo: nil)
        dismiss(animated: true)
    }
}

// MARK: - TextViewDelegate
extension ModalViewContoller: UITextViewDelegate {
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        if !titleTextField.isEnabled {
            return false
        }
        
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return changedText.count <= 1000
    }
}
