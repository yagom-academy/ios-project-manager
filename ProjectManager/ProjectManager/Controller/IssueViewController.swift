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
    }
    
    
    private func configureUI() {
        view.addSubview(stackView)
        view.backgroundColor = .systemBackground
        title = "TODO"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done")
        
        configureStackView()
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
    
    enum LayoutConstant {
        static let stackViewSpacing = CGFloat(8)
        static let margin = CGFloat(16)
    }
}
