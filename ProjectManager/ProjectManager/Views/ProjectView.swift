//
//  ProjectView.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/16.
//

import UIKit

final class ProjectView: UIView {
    // MARK: Private Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.placeholder = "제목없음"
        return textField
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.backgroundColor = .white
        return datePicker
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textView
    }()

    // MARK: Properties
    var isTexting: Bool = false
    var title: String {
        return titleTextField.text ?? "제목없음"
    }

    var projectDescription: String {
        return descriptionTextView.text
    }

    var dueDate: Date {
        return datePicker.date
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        configureConstraints()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configure View
    private func configureView() {
        backgroundColor = .systemBackground
        addSubview(stackView)

        [titleTextField, datePicker, descriptionTextView].forEach {
            stackView.addArrangedSubview($0)
        }
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])

        if #available(iOS 15.0, *) {
            stackView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor).isActive = true
        } else {
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }

    // MARK: Methods
    func configure(with project: Project) {
        titleTextField.text = project.title
        descriptionTextView.text = project.description
        datePicker.date = project.dueDate
    }

    func configureTextFieldDelegate(by viewController: UITextFieldDelegate) {
        titleTextField.delegate = viewController
    }

    func configureTextViewDelegate(by viewController: UITextViewDelegate) {
        descriptionTextView.delegate = viewController
    }

    func addDescriptionTextViewBottomContentInset(_ inset: CGFloat) {
        descriptionTextView.contentInset.bottom += inset
    }

    func resetDescriptionTextViewBottomContentInset() {
        descriptionTextView.contentInset.bottom = 0
    }
}
