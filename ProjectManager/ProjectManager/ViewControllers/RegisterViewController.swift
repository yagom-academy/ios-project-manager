//
//  RegisterViewController.swift
//  ProjectManager
//
//  Created by YB on 2021/06/29.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let leftButton = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: nil)
    let rightButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: nil)
    let registerTitle = UITextField()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    let registerDescription = UITextView()

    let stackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.alignment = .fill
        myStackView.spacing = 10
        
        return myStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTitle.backgroundColor = .yellow
        registerTitle.layer.shadowOffset = .zero
        registerTitle.layer.shadowColor = UIColor.black.cgColor
        registerTitle.layer.shadowOpacity = 5

        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(registerTitle)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(registerDescription)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        registerTitle.translatesAutoresizingMaskIntoConstraints = false
        registerDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            registerTitle.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
        
        
        registerDescription.backgroundColor = .green
    }
}
