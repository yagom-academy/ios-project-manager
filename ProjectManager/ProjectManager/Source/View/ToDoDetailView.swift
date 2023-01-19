//  ProjectManager - ToDoDetailView.swift
//  created by zhilly on 2023/01/19

import UIKit

class ToDoDetailView: UIView {
    private enum Constant {
        static let titlePlaceHolder = "Title"
        static let emptyTitle = "제목 없음"
        static let emptyBody = "내용 없음"
    }
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = Constant.titlePlaceHolder
        textField.font = UIFont.preferredFont(forTextStyle: .callout)
        textField.borderStyle = .none
        textField.backgroundColor = .systemBackground
        textField.layer.shadowColor = UIColor.systemGray2.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 5)
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 5.0
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.isUserInteractionEnabled = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        
        textView.text = Constant.emptyBody
        textView.font = UIFont.preferredFont(forTextStyle: .callout)
        textView.textColor = .black
        textView.backgroundColor = .systemBackground
        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.systemGray2.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 5)
        textView.layer.shadowOpacity = 1
        textView.layer.shadowRadius = 5.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleTextField)
        addSubview(datePicker)
        addSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            titleTextField.topAnchor.constraint(equalTo: self.topAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 12),
            bodyTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            bodyTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            bodyTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 12),
            bodyTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 12)
        ])
    }
    
    func validToDoTitle() -> Bool {
        if titleTextField.text != .init() {
            return true
        }
        return false
    }
    
    func currentContent() -> ToDoData {
        return ToDoData(title: titleTextField.text,
                        body: bodyTextView.text,
                        deadline: datePicker.date)
    }
    
    func setupContent(data: ToDoData) {
        titleTextField.text = data.title
        bodyTextView.text = data.body
        datePicker.date = data.deadline
    }
    
    func changeEditing(_ value: Bool) {
        titleTextField.isUserInteractionEnabled = value
        bodyTextView.isUserInteractionEnabled = value
        datePicker.isUserInteractionEnabled = value
    }
}
