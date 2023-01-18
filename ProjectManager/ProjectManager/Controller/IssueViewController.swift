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
    private var isEditable: Bool = true {
        didSet {
            titleTextField.isEnabled = isEditable
            datePicker.isEnabled = isEditable
            bodyTextView.isEditable = isEditable
        }
    }
    
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
    
    private var titleTextField: PaddedTextField = {
        let padding = UIEdgeInsets(top: LayoutConstant.titleTextFieldPadding,
                                   left: LayoutConstant.titleTextFieldPadding,
                                   bottom: LayoutConstant.titleTextFieldPadding,
                                   right: LayoutConstant.titleTextFieldPadding)
        let textField = PaddedTextField(padding: padding)
        textField.backgroundColor = .systemBackground
        textField.placeholder = Namespace.title
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.addShadow(radius: LayoutConstant.shadowRadius)
        
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
        textView.addShadow(radius: LayoutConstant.shadowRadius)
        
        return textView
    }()
    
    init(delegate: IssueManageable) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        configureNavigationBar()
    }
    
    init(issue: Issue, delegate: IssueManageable) {
        self.issue = issue
        self.delegate = delegate
        defer { self.isEditable = false }
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
        if issue == nil {
            title = Status.todo.description
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Namespace.done,
                                                                primaryAction: UIAction { _ in
                self.createIssue()
                self.delegate.addIssue(issue: self.issue)
                self.dismiss(animated: true)
            })
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: Namespace.cancel,
                                                               primaryAction: UIAction { _ in
                self.dismiss(animated: true)
            })
        } else {
            title = issue?.status.description
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Namespace.done,
                                                                primaryAction: UIAction { _ in
                self.updateIssue()
                self.delegate.updateIssue(issue: self.issue)
                self.dismiss(animated: true)
            })
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: Namespace.edit,
                                                               primaryAction: UIAction { _ in
                self.isEditable = true
            })
        }
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
        datePicker.date = issue.deadline
        bodyTextView.text = issue.body
    }
    
    private func createIssue() {
        issue = Issue(id: UUID(),
                      status: .todo,
                      title: titleTextField.text ?? Namespace.empty,
                      body: bodyTextView.text,
                      deadline: datePicker.date)
    }
    
    private func updateIssue() {
        issue?.title = titleTextField.text ?? Namespace.empty
        issue?.body = bodyTextView.text
        issue?.deadline = datePicker.date
    }
    
    enum LayoutConstant {
        static let stackViewSpacing = CGFloat(8)
        static let margin = CGFloat(20)
        static let titleTextFieldPadding = CGFloat(12)
        static let shadowRadius = CGFloat(4)
    }
    
    enum Namespace {
        static let maxBodyTextCount = 1000
        static let empty = ""
        static let done = "Done"
        static let edit = "Edit"
        static let cancel = "Cancel"
        static let title = "Title"
    }
}

extension IssueViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 1000 {
            textView.deleteBackward()
        }
    }
}
