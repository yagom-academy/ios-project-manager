//
//  AddProjectViewController.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/18.
//

import UIKit

final class AddProjectViewController: UIViewController {
    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력하세요"
        textField.font = UIFont.preferredFont(forTextStyle: .caption1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubviews()
        configureConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = NameSpace.title
        
        preferredContentSize = CGSize(width: 300, height: 300)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                               target: self,
                                               action: #selector(doneEdit))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                               target: self,
                                               action: #selector(doneEdit))
        
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func configureAddSubviews() {
        view.addSubview(contentView)
        contentView.addArrangedSubview(titleTextField)
        contentView.addArrangedSubview(datePicker)
        contentView.addArrangedSubview(descriptionTextView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func doneEdit() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func cancelEdit() {
        self.dismiss(animated: true)
    }
}

private enum NameSpace {
    static let title = "TODO"
}
