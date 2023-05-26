//
//  AddProjectViewController.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/18.
//

import UIKit

final class DetailProjectViewController: UIViewController {
    private let listViewModel = ListViewModel.shared
    private var isNewList: Bool

    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        textField.borderStyle = .roundedRect
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
        textView.font = UIFont.preferredFont(forTextStyle: .body)
//        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()

    init(isNewList: Bool) {
        self.isNewList = isNewList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubviews()
        configureConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = NameSpace.title
        
        self.preferredContentSize = CGSize(width: 300, height: 300)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButton))
        if isNewList {
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                               target: self,
                                               action: #selector(cancelButton))
            navigationItem.leftBarButtonItem = cancelButton
        } else {
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                             target: self,
                                             action: #selector(editButton))
            navigationItem.leftBarButtonItem = editButton
        }
        
        navigationItem.rightBarButtonItem = doneButton

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
    
    func configureContent(with list: ProjectModel) {
        titleTextField.text = list.title
        descriptionTextView.text = list.description
    }
    
    @objc
    private func doneButton() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else { return }
        
        let todoList = ProjectModel(title: title, description: description, deadLine: Date(), state: .todo)
        listViewModel.addProject(new: todoList)
        print(listViewModel.todoList.value)

        self.dismiss(animated: true)
    }
    
    @objc
    private func cancelButton() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func editButton() {
        descriptionTextView.isEditable = true
    }
}

private enum NameSpace {
    static let title = "TODO"
}
