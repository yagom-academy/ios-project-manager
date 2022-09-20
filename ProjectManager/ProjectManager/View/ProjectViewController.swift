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
    
    var addButtonAction = PublishSubject<Project>()
    var viewModel: ViewModelType?
    
    private let projectTitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = Design.projectTitlePlaceholder
        textField.addLeftPadding()
        textField.borderStyle = .roundedRect
        textField.appendShadow()
        
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: Design.localeIdentifier)
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneButtonDidTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelButtonDidTapped))
    }
}

// MARK: - objc functions

extension ProjectViewController {
    @objc private func cancelButtonDidTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneButtonDidTapped() {
        guard let title = projectTitle.text,
              let description = projectDescription.text else { return }
        let project = Project(title: "\(title)", description: "\(description)", date: datePicker.date)
        addButtonAction.onNext(project)
        dismiss(animated: true)
    }
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
}

private enum Design {
    static let navigationItemTitle = "Todo"
    static let localeIdentifier = "ko-KR"
    static let projectTitlePlaceholder = "Title"
}
