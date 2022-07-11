//
//  TodoEditView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import UIKit
import SnapKit

final class TodoEditView: UIView {
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTaxtField, datePicker, bodyTextView])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    let titleTaxtField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.backgroundColor = .systemBackground
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowRadius = 3
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.layer.masksToBounds = false
        textView.backgroundColor = .systemBackground
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowRadius = 3
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        titleTaxtField.snp.makeConstraints { make in
            make.height.equalTo(self).multipliedBy(0.08)
        }
    }
}

extension TodoEditView {
    func readViewContent() -> TodoModel {
        return TodoModel(title: titleTaxtField.text,
                         body: bodyTextView.text,
                         deadlineAt: datePicker.date)
    }
    
    func setupView(by item: TodoModel?) {
        guard let item = item else { return }
        titleTaxtField.text = item.title
        bodyTextView.text = item.body
        datePicker.date = item.deadlineAt
    }
}
