//
//  AddProjectViewController.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/18.
//

import UIKit

final class DetailProjectViewController: UIViewController {
    private let listViewModel = ListViewModel.shared
    private var isNewProject: Bool
    private var project: ProjectModel?

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
        textField.placeholder = NameSpace.titlePlaceholder
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
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 3
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()

    init(isNewProject: Bool) {
        self.isNewProject = isNewProject
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
        checktextEditable()
    }
    
    func configureContent(with project: ProjectModel) {
        self.project = project
        titleTextField.text = project.title
        descriptionTextView.text = project.description
        datePicker.date = project.deadLine
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = NameSpace.navigationTitle
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButton))
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelButton))
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                         target: self,
                                         action: #selector(editButton))
        
        let updateButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(updateButton))
    
        if isNewProject {
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = doneButton
        } else {
            navigationItem.leftBarButtonItem = editButton
            navigationItem.rightBarButtonItem = updateButton
        }
        
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
    
    private func checktextEditable() {
        if isNewProject {
            titleTextField.isEnabled = true
            descriptionTextView.isEditable = true
        } else {
            titleTextField.isEnabled = false
            descriptionTextView.isEditable = false
        }
    }
    
    @objc
    private func doneButton() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else { return }
        
        let date = datePicker.date
        let todoList = ProjectModel(title: title, description: description, deadLine: date, state: .todo)
        
        if checkInputValues() {
            listViewModel.addProject(new: todoList)
            self.dismiss(animated: true)
        }
    }
    
    @objc
    private func cancelButton() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func editButton() {
        titleTextField.isEnabled = true
        descriptionTextView.isEditable = true
    }
    
    @objc
    private func updateButton() {
        guard let project,
              let title = titleTextField.text,
              let description = descriptionTextView.text else { return }
        
        let date = datePicker.date
        
        if checkInputValues() {
            listViewModel.updateProject(state: project.state,
                                        id: project.id,
                                        title: title,
                                        description: description,
                                        deadLine: date)
            self.dismiss(animated: true)
        }
    }
    
    private func checkInputValues() -> Bool {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else { return false }
        
        if title.count == 0 || description.count == 0 {
            let alert = UIAlertController(title: nil,
                                          message: NameSpace.alertMessage,
                                          preferredStyle: .alert)
            
            let ok = UIAlertAction(title: NameSpace.ok, style: .cancel)
            alert.addAction(ok)
            present(alert, animated: true)
            
            return false
        }
        
        return true
    }
}

private enum NameSpace {
    static let navigationTitle = "TODO"
    static let titlePlaceholder = "Title"
    static let alertMessage = "제목 혹은 내용을 입력해주세요"
    static let ok = "확인"
}
