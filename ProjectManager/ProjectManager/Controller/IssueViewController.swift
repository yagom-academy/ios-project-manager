//
//  IssueViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/16.
//

import UIKit

final class IssueViewController: UIViewController {
    private enum Constant {
        enum LayoutConstant {
            static let stackViewSpacing = CGFloat(8)
            static let margin = CGFloat(20)
            static let titleTextFieldPadding = CGFloat(12)
            static let shadowRadius = CGFloat(4)
        }
        
        enum Namespace {
            static let maxBodyTextCount = 1000
            static let done = "Done"
            static let edit = "Edit"
            static let cancel = "Cancel"
            static let title = "Title"
        }
    }
    
    private var issue: Issue
    private var delegate: IssueDelegate?
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
        stack.spacing = Constant.LayoutConstant.stackViewSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: Constant.LayoutConstant.margin,
            leading: Constant.LayoutConstant.margin,
            bottom: Constant.LayoutConstant.margin,
            trailing: Constant.LayoutConstant.margin
        )
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var titleTextField: PaddedTextField = {
        let padding = UIEdgeInsets(
            top: Constant.LayoutConstant.titleTextFieldPadding,
            left: Constant.LayoutConstant.titleTextFieldPadding,
            bottom: Constant.LayoutConstant.titleTextFieldPadding,
            right: Constant.LayoutConstant.titleTextFieldPadding
        )
        let textField = PaddedTextField(padding: padding)
        textField.backgroundColor = .systemBackground
        textField.placeholder = Constant.Namespace.title
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.addShadow(radius: Constant.LayoutConstant.shadowRadius)
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
        textView.addShadow(radius: Constant.LayoutConstant.shadowRadius)
        return textView
    }()
    
    init(delegate: IssueDelegate) {
        self.delegate = delegate
        self.issue = Issue(
            id: UUID(),
            status: .todo,
            title: String.init(),
            body: String.init(),
            deadline: datePicker.date
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    init(issue: Issue, delegate: IssueDelegate) {
        self.issue = issue
        self.delegate = delegate
        defer { self.isEditable = false }
        super.init(nibName: nil, bundle: nil)
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
        configureNavigationBar()
        configureStackView()
    }
    
    private func configureNavigationBar() {
        if isEditable {
            title = String(describing: Status.todo)
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: Constant.Namespace.done,
                primaryAction: UIAction { _ in
                    self.updateIssue()
                    self.delegate?.shouldAdd(issue: self.issue)
                    self.dismiss(animated: true)
                })
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: Constant.Namespace.cancel,
                primaryAction: UIAction { _ in
                    self.dismiss(animated: true)
                })
        } else {
            title = String(describing: issue.status)
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: Constant.Namespace.done,
                primaryAction: UIAction { _ in
                    self.updateIssue()
                    self.delegate?.shouldUpdate(issue: self.issue)
                    self.dismiss(animated: true)
                })
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: Constant.Namespace.edit,
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
        
        [titleTextField, datePicker, bodyTextView].forEach(stackView.addArrangedSubview(_:))
    }
    
    private func configureContents() {
        titleTextField.text = issue.title
        datePicker.date = issue.deadline
        bodyTextView.text = issue.body
    }
    
    private func updateIssue() {
        issue.title = titleTextField.text ?? String.init()
        issue.body = bodyTextView.text
        issue.deadline = datePicker.date
    }
}

extension IssueViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > Constant.Namespace.maxBodyTextCount {
            textView.deleteBackward()
        }
    }
}
