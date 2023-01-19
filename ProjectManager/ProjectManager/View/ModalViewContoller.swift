//
//  ModalViewContoller.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/13.
//

import UIKit

final class ModalViewContoller: UIViewController {
    private let data: TodoModel?
    private let coreDataManager = CoreDataManager()
    
    private let textField: UITextField = {
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
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        
        return datePicker
    }()
    
    private let textView: UITextView = {
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
        textView.delegate = self
        
        configureLayout()
        setNavigation()
        setData()
    }
    
    private func isChange(input: Bool) {
        textView.isSelectable = input
        textField.isEnabled = input
        datePicker.isEnabled = input
        navigationItem.rightBarButtonItem?.isEnabled = input
    }
    
    private func setData() {
        guard let data = data,
              let todoDate = data.todoDate else { return }
        
        textField.text = data.title
        datePicker.date = todoDate
        textView.text = data.body
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
                action: #selector(tapRightButton)
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
            action: #selector(tapUpdateRightButton)
        )
        navigationItem.rightBarButtonItem = rightBarButton
        isChange(input: false)
    }
    
    @objc private func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func tapEditButton() {
        if navigationItem.leftBarButtonItem?.title == "Cancel" {
            dismiss(animated: true)
        }
        isChange(input: true)
        navigationItem.leftBarButtonItem?.title = "Cancel"
    }
    
    @objc private func tapRightButton() {
        guard let title = textField.text else { return }
        guard let body = textView.text else { return }
        
        coreDataManager.saveData(title: title, body: body, todoDate: datePicker.date)
        
        let notification = Notification.Name("DismissForReload")
        NotificationCenter.default.post(name: notification, object: nil, userInfo: nil)
        dismiss(animated: true)
    }
    
    @objc private func tapUpdateRightButton() {
        guard let title = textField.text else { return }
        guard let body = textView.text else { return }
        guard let id = data?.id else { return }
        guard let state = data?.state,
              let state = State(rawValue: state) else { return }
        
        coreDataManager.updateData(title: title, body: body, todoDate: datePicker.date, id: id, state: state)
        
        let notification = Notification.Name("DismissForReload")
        NotificationCenter.default.post(name: notification, object: nil, userInfo: nil)
        dismiss(animated: true)
    }
    
    private func configureLayout() {
        [textField, datePicker, textView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeArea.topAnchor),
            textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            
            datePicker.topAnchor.constraint(equalTo: textField.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            
            textView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            textView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - TextViewDelegate
extension ModalViewContoller: UITextViewDelegate {
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return changedText.count <= 1000
    }
}
