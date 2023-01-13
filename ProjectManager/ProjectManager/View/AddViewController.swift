//
//  AddViewController.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/13.
//

import UIKit

class AddViewController: UIViewController {

    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.borderStyle = .line
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureLayout()
        view.backgroundColor = .white
    }
    
    func configureNavigation() {
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done)
        navigationController?.navigationBar.backgroundColor = .systemGray5
    }
    
    func configureLayout() {
        view.addSubview(titleTextField)
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
