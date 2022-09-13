//
//  TodoAddView.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/12.
//

import UIKit

class TodoAddView: UIView {
    
    //MARK: - UI Properties

    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.placeholder = "title"
        textField.borderStyle = .roundedRect
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowColor = UIColor.gray.cgColor
        return textField
    }()  
    
    let deadLineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.isScrollEnabled = true
        textView.sizeToFit()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        
        
        
        textView.layer.masksToBounds = false
        textView.layer.shadowOpacity = 1
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowColor = UIColor.gray.cgColor
        textView.layer.shadowOpacity = 1.0
        textView.text = "이곳에 설명을 기입해주세요"
        return textView
    }()
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        addUIComponents()
        setupListViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension TodoAddView {
    
    //MARK: - Setup List View Initial State
    
    func addUIComponents() {
        self.addSubview(titleTextField)
        self.addSubview(deadLineDatePicker)
        self.addSubview(descriptionTextView)
    }
    
    func setupListViewLayout() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            deadLineDatePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            deadLineDatePicker.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            deadLineDatePicker.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: deadLineDatePicker.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
