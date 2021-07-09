//
//  EditViewController.swift
//  ProjectManager
//
//  Created by YB on 2021/07/09.
//

import UIKit

class EditViewController: UIViewController {
    
    let leftButton = UIBarButtonItem.init(title: "Edit",
                                          style: .done,
                                          target: self,
                                          action: nil)

    let rightButton = UIBarButtonItem.init(title: "Done",
                                           style: .done,
                                           target: self,
                                           action: nil)
    
    var indexPath: IndexPath!
    var task: Task!
    
    let stackView: UIStackView = {
        let myStackView = UIStackView()

        myStackView.axis = .vertical
        myStackView.alignment = .fill
        myStackView.spacing = 10
        myStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return myStackView
    }()

    let registerTitle: UITextField = {
        let registerTitle = UITextField()

        registerTitle.backgroundColor = .white
        registerTitle.font = UIFont.preferredFont(forTextStyle: .title3)
        registerTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        registerTitle.layer.shadowColor = UIColor.black.cgColor
        registerTitle.layer.shadowOpacity = 0.6
        registerTitle.clipsToBounds = false
        registerTitle.placeholder = "Title"

        registerTitle.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: registerTitle.frame.height))
        registerTitle.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: registerTitle.frame.height))
        registerTitle.leftViewMode = .always
        registerTitle.rightViewMode = .always
        registerTitle.translatesAutoresizingMaskIntoConstraints = false

        return registerTitle
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()
    
    let registerDescription: UITextView = {
        let description = UITextView()

        description.backgroundColor = .white
        description.font = UIFont.preferredFont(forTextStyle: .title3)
        description.layer.shadowOffset = CGSize(width: 0, height: 3)
        description.layer.shadowColor = UIColor.black.cgColor
        description.layer.shadowOpacity = 0.6
        description.clipsToBounds = false
        description.text = "설명을 입력해주세요"
        description.textColor = UIColor.lightGray
        description.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = task.status
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(registerTitle)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(registerDescription)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            registerTitle.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
    }
}
