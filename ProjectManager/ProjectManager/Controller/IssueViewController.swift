//
//  IssueViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/16.
//

import UIKit

class IssueViewController: UIViewController {
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = LayoutConstant.stackViewSpacing
        
        return stack
    }()
    
    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Title"
        
        return textField
    }()
    
    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .wheels
        
        return picker
    }()
    
    private var bodyTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Body"
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    private func configureUI() {
        view.addSubview(stackView)
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(bodyTextField)
    }
    
    enum LayoutConstant {
        static let stackViewSpacing = CGFloat(8)
    }
}
