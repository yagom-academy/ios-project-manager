//
//  ModalViewController.swift
//  ProjectManager
//
//  Created by kimseongjun on 2023/05/22.
//

import UIKit

class ModalViewController: UIViewController {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let datePickerView: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: "ko_KR")
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    private let contentTextView: UITextView = {
        let contentTextView = UITextView()
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "TODO"
        configureUI()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.layer.cornerRadius = 20
        
        view.addSubview(titleTextField)
        view.addSubview(datePickerView)
        view.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
            datePickerView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            datePickerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            datePickerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            contentTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
        ])
        
    }
}
