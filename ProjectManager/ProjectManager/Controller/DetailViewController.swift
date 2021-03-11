//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/11.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Property
    
    var isNew: Bool = false
    var index: Int? = nil
    var thing: Thing? = nil
    var tableViewType: TableViewType? = nil
    
    // MARK: - Outlet
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        makeShadow(view: textField)
        textField.backgroundColor = .white
        textField.placeholder = Strings.titlePlaceHolder
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.isUserInteractionEnabled = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    let bodyTextView: UITextView = {
        let textView = UITextView()
        makeShadow(view: textView)
        textView.text = Strings.bodyPlaceHolder
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        return textView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        configureNavigationBar()
        setContents()
    }
    
    // MARK: - UI
    
    private func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(datePicker)
        view.addSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            
            bodyTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            bodyTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            bodyTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            bodyTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
        ])
    }
    
    static private func makeShadow(view: UIView) {
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
    }
    
    private func setContents() {
        guard let thing = thing else {
            return
        }
        titleTextField.text = thing.title
        bodyTextView.text = thing.description
        datePicker.date = thing.date
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(touchUpDoneButton))
        if isNew {
            toggleEditMode()
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(touchUpEditButton))
        }
    }
    
    @objc private func touchUpDoneButton() {
        guard let title = titleTextField.text, let body = bodyTextView.text else {
            return
        }
        let date = Int(datePicker.date.timeIntervalSince1970)
        let thing = Thing(title: title, description: body, dateNumber: date)
        
        if isNew {
            Things.shared.todoList.insert(thing, at: 0)
        } else if let index = index {
            if tableViewType == .todo {
                Things.shared.todoList[index] = thing
            } else if tableViewType == .doing {
                Things.shared.doingList[index] = thing
            } else {
                Things.shared.doneList[index] = thing
            }
        }
        NotificationCenter.default.post(name: Strings.reloadNotification, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func touchUpCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func touchUpEditButton() {
        toggleEditMode()
    }
    
    private func toggleEditMode() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(touchUpCancelButton))
        titleTextField.isUserInteractionEnabled = true
        datePicker.isUserInteractionEnabled = true
        bodyTextView.isEditable = true
    }
}
