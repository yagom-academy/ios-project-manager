//
//  ProjectViewController.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import UIKit
import RxSwift

final class ProjectViewController: UIViewController {
    
    // MARK: - properties
    
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                       target: nil,
                                       action: nil)
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                       target: nil,
                                       action: nil)
    
    let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                       target: nil,
                                       action: nil)
    
    var viewModel: ViewModelType?
    
    private var id: UUID?
    private var status: Status?
    
    let projectTitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = Design.projectTitlePlaceholder
        textField.addLeftPadding()
        textField.borderStyle = .roundedRect
        textField.appendShadow()
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: Design.localeIdentifier)
        datePicker.timeZone = .autoupdatingCurrent
        
        return datePicker
    }()
    
    private let projectDescription: UITextView = {
        let textView = UITextView()
        textView.appendShadow()
        
        return textView
    }()
    
    private let projectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupNavigationItem()
    }
}

// MARK: - functions

extension ProjectViewController {
    private func setupStackView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(projectStackView)
        
        projectStackView.addArrangedSubview(projectTitle)
        projectStackView.addArrangedSubview(datePicker)
        projectStackView.addArrangedSubview(projectDescription)
        
        NSLayoutConstraint.activate([
            projectStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            projectStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            projectStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupNavigationItem() {
        navigationItem.title = Design.navigationItemTitle
        
        if id == nil {
            navigationItem.rightBarButtonItem = doneButton
        } else {
            navigationItem.rightBarButtonItem = editButton
        }
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func getProjectData() -> Project? {
        guard let title = projectTitle.text else { return nil }
        return Project(uuid: id ?? UUID(),
                       status: status ?? .todo,
                       title: title,
                       description: self.projectDescription.text,
                       date: self.datePicker.date)
    }
    
    func setupData(project: Project) {
        self.id = project.uuid
        self.status = project.status
        self.projectTitle.text = project.title
        self.datePicker.date = project.date
        self.projectDescription.text = project.description
    }
}

// MARK: - Design

private enum Design {
    static let navigationItemTitle = "Todo"
    static let localeIdentifier = "ko-KR"
    static let projectTitlePlaceholder = "Title"
}
