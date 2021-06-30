//
//  RegisterViewController.swift
//  ProjectManager
//
//  Created by YB on 2021/06/29.
//

import UIKit

class RegisterViewController: UIViewController {

    let stackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.alignment = .fill
        
        return myStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "TODO"

        let leftButton = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: nil)
        let rightButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: nil)

        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1)
        ])
        
//        stackView.backgroundColor = .green
        
        let title = UILabel()
        let datePicker = UIDatePicker()
        let textField = UITextField()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        title.backgroundColor = .yellow
        textField.backgroundColor = .green

        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textField)
        
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            title.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
}
