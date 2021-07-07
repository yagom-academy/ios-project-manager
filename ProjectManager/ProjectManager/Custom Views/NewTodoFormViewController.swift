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
        
            return
        }

        
        if let title = newTodoFormTextField.text, let description = newTodoFormTextView.text {
            
            delegate?.dataPassing(title: title, date: formattedDate(date: datePicker.date), description: description)
        }
        projectManagerViewController.todoTitleView.count.text = String(projectManagerViewController.data.count)
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
            newTodoFormTextField.heightAnchor.constraint(equalToConstant: view.frame.size.height / 19 )
        ])
    }
    
    private func configureDatePicker() {
        newTodoFormStackView.addArrangedSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalToConstant: view.frame.size.height / 4)
        ])
    }
    
    private func configureNewTodoFormTextView() {
        newTodoFormStackView.addArrangedSubview(newTodoFormTextView)
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
