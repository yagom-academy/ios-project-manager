//
//  TodoDetailViewController.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/09.
//

import UIKit
import RxSwift

final class TodoDetailViewController: UIViewController {

    // MARK: - Properties
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        let leftPaddingView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 30,
            height: 0
        ))
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.placeholder = "Title"
        textField.textAlignment = .left
        textField.leftViewMode = .always
        textField.leftView = leftPaddingView
        
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .autoupdatingCurrent
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    
    let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.adjustsFontForContentSizeCategory = true
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainerInset = UIEdgeInsets(
            top: 15,
            left: 15,
            bottom: 15,
            right: 15
        )
        textView.keyboardDismissMode = .interactive
        textView.alwaysBounceVertical = true
        
        return textView
    }()
    
    private lazy var bodyTextShadowView: UIView = {
        let view = UIView(frame: bodyTextView.frame)
        view.backgroundColor = .brown
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let cancelButton = UIBarButtonItem(
        barButtonSystemItem: .cancel,
        target: nil,
        action: nil
    )
    
    let doneButton = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: nil,
        action: nil
    )
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
        configureNavigationBar()
        
        configureShadow(titleTextField)
        configureShadow(bodyTextShadowView)
    }
}

// MARK: - Configure Methods

extension TodoDetailViewController {
    private func configureNavigationBar() {
        title = "TODO"
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backgroundColor = .systemGray6
        
        navigationItem.setLeftBarButton(cancelButton, animated: true)
        navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    private func configureHierarchy() {
        view.addSubview(bodyTextShadowView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleTextField)
        mainStackView.addArrangedSubview(datePicker)
        mainStackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureLayout() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            mainStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            )
        ])
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(
                equalTo: datePicker.heightAnchor,
                multiplier: 0.2
            )
        ])
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.3
            )
        ])
        
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyTextView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.5
            )
        ])
        
        bodyTextShadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyTextShadowView.topAnchor.constraint(equalTo: bodyTextView.topAnchor),
            bodyTextShadowView.bottomAnchor.constraint(equalTo: bodyTextView.bottomAnchor),
            bodyTextShadowView.leadingAnchor.constraint(equalTo: bodyTextView.leadingAnchor),
            bodyTextShadowView.trailingAnchor.constraint(equalTo: bodyTextView.trailingAnchor)
        ])
    }
    
    private func configureShadow(_ view: UIView) {
        view.backgroundColor = .white

        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray6.cgColor

        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize(
            width: 3,
            height: 3
        )
        view.layer.shadowColor = UIColor.gray.cgColor
    }
}

// MARK: - Getter Methods

extension TodoDetailViewController {
    func getCurrentTodoInfomation(todoId: UUID? = nil, status: TodoStatus? = nil, isOutdated: Bool? = nil) -> Todo? {
        guard let title = self.titleTextField.text,
              let body = self.bodyTextView.text else { return nil }
        let date = self.datePicker.date
        
        var newTodoId = UUID()
        var newStatus = TodoStatus.todo
        var newIsOutdated = false
        
        if let todoId = todoId,
           let status = status,
           let isOutdated = isOutdated {
            newTodoId = todoId
            newStatus = status
            newIsOutdated = isOutdated
        }
        
        let currentTodoInfomation = Todo(
            todoId: newTodoId,
            title: title,
            body: body,
            createdAt: date,
            status: newStatus,
            isOutdated: newIsOutdated
        )
        
        return currentTodoInfomation
    }
}
