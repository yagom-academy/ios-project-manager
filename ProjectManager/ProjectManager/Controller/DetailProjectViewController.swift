//
//  ProjectManager - DetailProjectViewController.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class DetailProjectViewController: UIViewController {
    private var projects = Projects.shared
    private var project: Project?
    var dismissHandler: (() -> ())?
    
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.backgroundColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = CGColor(gray: 0.5, alpha: 0)
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.backgroundColor = .white
        textView.setContentOffset(CGPoint(x: 10, y: 10), animated: false)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = CGColor(gray: 0.5, alpha: 1)
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 2
        textView.layer.shadowOffset = CGSize(width: 0, height: 1)
        textView.layer.cornerRadius = 5
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureContentStackView()
        configureConstraint()
    }
    
    func configureEditingStatus(isEditible: Bool) {
        if !isEditible {
            titleTextField.isEnabled = false
            datePicker.isEnabled = false
            bodyTextView.isEditable = false
            
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                             target: self,
                                             action: #selector(editProject))
            navigationItem.leftBarButtonItem = editButton
        } else {
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                               target: self,
                                               action: #selector(cancelEditingProject))
            navigationItem.leftBarButtonItem = cancelButton
        }
    }
    
    func configureProject(assignedProject: Project) {
        project = assignedProject
        
        guard let date = project?.date else { return }
        
        titleTextField.text = project?.title
        bodyTextView.text = project?.body
        datePicker.date = date
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(displayP3Red: 200/255,
                                                                      green: 200/255,
                                                                      blue: 200/255, alpha: 0.5)
        
        title = "TODO"
        

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneEditingProject))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc
    private func editProject() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelEditingProject))
        navigationItem.leftBarButtonItem = cancelButton
        
        toggleEditMode()
    }
    
    @objc
    private func doneEditingProject() {
        guard let title = titleTextField.text else { return }
        guard let body = bodyTextView.text else { return }
        
        let date = datePicker.date
        
        guard title != "" && body != "" else {
            displayEmptyAlert()
            return
        }
        
        if project == nil {
            let project = Project(title: title, body: body, date: date, status: .todo)
            projects.list.append(project)
        } else {
            guard let editIndex = self.projects.list.firstIndex(where: { $0.id == project?.id }) else { return }
            projects.list[editIndex].title = title
            projects.list[editIndex].date = date
            projects.list[editIndex].body = body
        }
        
        dismissHandler?()
        self.dismiss(animated: true)
    }
    
    @objc
    private func cancelEditingProject() {
        self.dismiss(animated: true)
        toggleEditMode()
    }
    
    private func toggleEditMode() {
        titleTextField.isEnabled.toggle()
        datePicker.isEnabled.toggle()
        bodyTextView.isEditable.toggle()
    }
    
    private func displayEmptyAlert() {
        let alert = UIAlertController(title: nil, message: "project의 제목과 내용을 입력하세요.", preferredStyle: UIAlertController.Style.alert)
        let okayAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okayAction)
        
        self.present(alert, animated: false)
    }
    
    private func configureContentStackView() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleTextField)
        contentStackView.addArrangedSubview(datePicker)
        contentStackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            bodyTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
        ])
    }
    
}
