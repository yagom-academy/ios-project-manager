//
//  NewTODOViewController.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/22.
//

import UIKit

final class NewTODOViewController: UIViewController {
    private let titleTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Title"
        textField.text = "텍스트필드"
        
        return textField
    }()
    
    private let bodyTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.backgroundColor = .brown
        textView.text = "텍스트뷰"
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleTextField)
//        view.addSubview(bodyTextView)
    }
    
    private func configureNavigation() {
        let editButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedEditButton))
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tappedDoneButton))
        navigationItem.rightBarButtonItem = editButton
        navigationItem.leftBarButtonItem = doneButton
        navigationItem.title = "여기에 제목불러오기"
    }
    
    @objc private func tappedEditButton() {
        
    }
    
    @objc private func tappedDoneButton() {
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            titleTextField.heightAnchor.constraint(equalToConstant: 64),
            
//            bodyTextView.heightAnchor.constraint(equalToConstant: 64),
//            bodyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
//            bodyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
//            bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}


