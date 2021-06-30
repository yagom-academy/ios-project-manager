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
    let labelTitle = UILabel()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    let textField = UITextField()

    let stackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.alignment = .fill
        
        return myStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textField)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1),
            
            labelTitle.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            labelTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
        
        labelTitle.backgroundColor = .yellow
        textField.backgroundColor = .green
    }
}
