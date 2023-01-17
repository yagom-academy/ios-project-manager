//
//  WorkFormViewController.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/13.
//

import UIKit

class WorkFormViewController: UIViewController {
    var work: Work?
    weak var delegate: WorkDelegate?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.backgroundColor = .systemBackground
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.clipsToBounds = false
        textView.backgroundColor = .systemBackground
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowOpacity = 0.3
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
        configureWork()
        view.backgroundColor = .white
    }
    
    func configureWork() {
        guard let work = work else { return }
        titleTextField.text = work.title
        bodyTextView.text = work.body
        datePicker.date = work.endDate
    }
    func configureNavigationBar() {
        navigationItem.title = "TODO"
        if work != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self,
                                                               action: #selector(editButtonTapped))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                                                               action: #selector(cancelButtonTapped))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                                            action: #selector(rightButtonTapped))
        navigationController?.navigationBar.backgroundColor = .systemGray5
    }
    
    func configureLayout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func editButtonTapped() {
        guard var work,
              let title = titleTextField.text,
              let body = bodyTextView.text else { return }
        work.title = title
        work.body = body
        
        delegate?.send(data: work)
        dismiss(animated: true)
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func rightButtonTapped() {
        guard let title = titleTextField.text,
              let body = bodyTextView.text else { return }
        
        delegate?.send(data: Work(category: .todo, title: title, body: body, endDate: datePicker.date))
        dismiss(animated: true)
    }
}
