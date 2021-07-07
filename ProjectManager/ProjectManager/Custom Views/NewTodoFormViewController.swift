//
//  NewTodoFormViewController.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/05.
//

import UIKit

class NewTodoFormViewController: UIViewController {
    
    let newTodoFormStackView = NewTodoFormStackView()
    let newTodoFormTextField = NewTodoFormTextField()
    let datePicker = UIDatePicker()
    let newTodoFormTextView = NewTodoFormTextView()
    
    var delegate: ProjectManagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneViewController))
        
        configiureNewTodoFormStackView()
        configureNewTodoFormTextField()
        configureDatePicker()
        configureNewTodoFormTextView()
        createDismissKeyboardTapGestrue()
    }
 
    
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc private func doneViewController() {
        
        guard let presentingViewController = presentingViewController as? UINavigationController,
              let projectManagerViewController = presentingViewController.viewControllers[0] as? ProjectManagerViewController else {
            
            print("return")
            return
        }

        
        if let title = newTodoFormTextField.text, let description = newTodoFormTextView.text {
            
            delegate?.dataPassing(title: title, date: formattedDate(date: datePicker.date), description: description)
        }
        
        projectManagerViewController.toDoTableView.reloadData()
        dismiss(animated: true) {
            self.newTodoFormTextField.text = ""
            self.newTodoFormTextView.text = ""
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: datePicker.date)
        
        return date
    }
    
    private func createDismissKeyboardTapGestrue() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func configureNewTodoFormTextField() {
        datePicker.preferredDatePickerStyle = .wheels
        newTodoFormStackView.addArrangedSubview(newTodoFormTextField)

        NSLayoutConstraint.activate([
            newTodoFormTextField.heightAnchor.constraint(equalToConstant: 50),
            newTodoFormTextField.topAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.topAnchor, constant: 10),
            newTodoFormTextField.leadingAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.leadingAnchor, constant: 10),
            newTodoFormTextField.trailingAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureDatePicker() {
        newTodoFormStackView.addArrangedSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: newTodoFormTextField.safeAreaLayoutGuide.bottomAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureNewTodoFormTextView() {
        newTodoFormStackView.addArrangedSubview(newTodoFormTextView)
        
        NSLayoutConstraint.activate([
            newTodoFormTextView.topAnchor.constraint(equalTo: datePicker.safeAreaLayoutGuide.bottomAnchor),
            newTodoFormTextView.leadingAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.leadingAnchor, constant: 10),
            newTodoFormTextView.trailingAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.trailingAnchor, constant: -10),
            newTodoFormTextView.bottomAnchor.constraint(equalTo: newTodoFormStackView.layoutMarginsGuide.bottomAnchor, constant: -25)
        ])
    }
    
    private func configiureNewTodoFormStackView() {
        view.addSubview(newTodoFormStackView)
        
        NSLayoutConstraint.activate([
            newTodoFormStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newTodoFormStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newTodoFormStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newTodoFormStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
