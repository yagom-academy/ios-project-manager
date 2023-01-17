//
//  IssueViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/16.
//

import UIKit

final class IssueViewController: UIViewController {
    private var issue: Issue?
    private var delegate: IssueManageable
    private var isEditable: Bool
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = LayoutConstant.stackViewSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: LayoutConstant.margin,
                                                                 leading: LayoutConstant.margin,
                                                                 bottom: LayoutConstant.margin,
                                                                 trailing: LayoutConstant.margin)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Title"
        textField.setContentHuggingPriority(.required, for: .vertical)
        
        return textField
    }()
    
    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = .current
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    private var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        return textView
    }()
    
    init(delegate: IssueManageable) {
        self.delegate = delegate
        self.isEditable = true
        super.init(nibName: nil, bundle: nil)
        configureNavigationBar()
    }
    
    init(issue: Issue, delegate: IssueManageable) {
        self.issue = issue
        self.delegate = delegate
        self.isEditable = false
        super.init(nibName: nil, bundle: nil)
        configureNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureContents()
    }
    
    
    private func configureUI() {
        view.addSubview(stackView)
        view.backgroundColor = .systemBackground
        configureStackView()
    }
    
    private func configureNavigationBar() {
        title = (issue == nil ? Status.todo.description : issue?.status.description)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            primaryAction: UIAction { _ in
            if self.issue == nil {
                self.createIssue()
                self.delegate.addIssue(issue: self.issue)
            } else {
                self.delegate.updateIssue(issue: self.issue)
            }

            self.dismiss(animated: true)
        })
    }
    
    private func createIssue() {
        issue = Issue(status: .todo,
                      title: titleTextField.text ?? Namespace.empty,
                      body: bodyTextView.text,
                      dueDate: datePicker.date)
    }
    
    private func configureStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureContents() {
        guard let issue = issue else { return }
        titleTextField.text = issue.title
        datePicker.date = issue.dueDate
        bodyTextView.text = issue.body
    }
        
    enum LayoutConstant {
        static let stackViewSpacing = CGFloat(8)
        static let margin = CGFloat(16)
    }
    
    enum Namespace {
        static let maxBodyTextCount = 1000
        static let empty = ""
    }
}
