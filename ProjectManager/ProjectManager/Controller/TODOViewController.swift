//
//  TODOViewController.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/22.
//

import UIKit

final class TODOViewController: UIViewController {
    private let datePicker: UIDatePicker = UIDatePicker()
    private var text: ProjectManager
    private var writeMode: WriteMode
    private let tableViewTag: Int
    private let indexPath: IndexPath?
    var delegate: NewTODOViewControllerDelegate?

    
    private let titleTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let bodyTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        configureDatePicker()
        configureLayout()
        configureText(text: text)
        
    }
    
    init(writeMode: WriteMode, text: ProjectManager, tableViewTag: Int, indexPath: IndexPath?) {
        self.writeMode = writeMode
        self.text = text
        self.tableViewTag = tableViewTag
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(selectDatePicker), for: .allEvents)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        bodyTextView.delegate = self
        titleTextField.delegate = self
        view.addSubview(titleTextField)
        view.addSubview(datePicker)
        view.addSubview(bodyTextView)
    }
    
    private func configureNavigation() {
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancelButton))
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tappedDoneButton))
        let editButton: UIBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(tappedEditButton))
        
        switch writeMode {
        case .edit:
            navigationItem.leftBarButtonItem = editButton
            titleTextField.isEnabled = false
            bodyTextView.isEditable = false
            datePicker.isEnabled = false
        case .new:
            navigationItem.leftBarButtonItem = cancelButton
        }
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "TODO"
    }
    
    private func configureText(text: ProjectManager) {
        titleTextField.text = text.title
        bodyTextView.text = text.body
        guard let date = text.deadline else{
            return
        }
        datePicker.date = date
    }
    
    @objc private func tappedEditButton() {
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancelButton))
        navigationItem.leftBarButtonItem = cancelButton
        titleTextField.isEnabled = true
        bodyTextView.isEditable = true
        datePicker.isEnabled = true
        view.layoutIfNeeded()
    }
    
    @objc private func tappedCancelButton() {
        if writeMode == .edit {
            let editButton: UIBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(tappedEditButton))
            navigationItem.leftBarButtonItem = editButton
            titleTextField.isEnabled = false
            bodyTextView.isEditable = false
            datePicker.isEnabled = false
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc private func tappedDoneButton() {
        if text.deadline == nil {
            text.deadline = Date()
        }
        delegate?.getText(text: text, writeMode: writeMode, tableViewTag: tableViewTag, indexPath: indexPath)
        dismiss(animated: true)
    }
    
    @objc private func selectDatePicker() {
        text.deadline = datePicker.date
        print(text.deadline as Any)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 64),
            
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
            bodyTextView.heightAnchor.constraint(equalToConstant: 300),
            bodyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bodyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

extension TODOViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        text.title = textField.text
    }
}


extension TODOViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        text.body = textView.text
    }

}

protocol NewTODOViewControllerDelegate: AnyObject {
    func getText(text: ProjectManager, writeMode: WriteMode, tableViewTag: Int, indexPath: IndexPath?)
}


