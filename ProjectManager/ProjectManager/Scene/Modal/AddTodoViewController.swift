//
//  AddTodoViewController.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import UIKit

class AddTodoViewController: UIViewController {

// MARK: - View Components

    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = AddTodoVCScript.cancel
        button.target = self
        button.action = #selector(cancelButtonDidTap)

        return button
    }()

    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = AddTodoVCScript.done
        button.target = self
        button.action = #selector(doneButtonDidTap)

        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AddTodoVCConstraint.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AddTodoVCScript.textFieldPlaceHolder

        return textField
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.date = Date()
        datePicker.datePickerMode = .date

        let locale = Locale.preferredLanguages.first ?? Locale.current.identifier
        datePicker.locale = Locale(identifier: locale)

        return datePicker
    }()

    private let textView: UITextView = {
        let textView = UITextView()

        return textView
    }()

// MARK: - Override Method(s)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpController()
        self.view.backgroundColor = .white
    }

// MARK: - SetUp Controller

    private func setUpController() {
        self.configureStackView()
        self.configureNavigationBar()
        self.setUpTextView()
    }

    private func setUpTextView() {
        self.textView.delegate = self
        self.textView.text = AddTodoVCScript.textViewPlaceHolder
        self.textView.textColor = UIColor.lightGray
    }

// MARK: - Configure View

    private func configureStackView() {
        self.view.addSubview(self.stackView)
        self.setStackViewConstraints()
        self.addViewsToStackView()
    }

    private func addViewsToStackView() {
        self.stackView.addArrangedSubview(self.textField)
        self.stackView.addArrangedSubview(self.datePicker)
        self.stackView.addArrangedSubview(self.textView)
    }

    private func configureNavigationBar() {
        self.title = AddTodoVCScript.title
        self.navigationItem.leftBarButtonItem = self.cancelButton
        self.navigationItem.rightBarButtonItem = self.doneButton
    }

// MARK: - add View Constraints

    private func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: AddTodoVCConstraint.stackViewPadding
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: -(AddTodoVCConstraint.stackViewBottomPadding)
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                constant: AddTodoVCConstraint.stackViewPadding
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                constant: -(AddTodoVCConstraint.stackViewPadding)
            )
        ])
    }

    private func setTextFieldConstraints() {
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(
                equalTo: self.stackView.topAnchor
            ),
            self.textField.bottomAnchor.constraint(
                equalTo: self.stackView.topAnchor,
                constant: AddTodoVCConstraint.textFieldHeight
            ),
            self.textField.leadingAnchor.constraint(
                equalTo: self.stackView.leadingAnchor
            ),
            self.textField.trailingAnchor.constraint(
                equalTo: self.stackView.trailingAnchor
            )
        ])
    }

    private func setDatePickerConstraints() {
        NSLayoutConstraint.activate([
            self.datePicker.topAnchor.constraint(
                equalTo: self.stackView.topAnchor,
                constant: AddTodoVCConstraint.textFieldHeight
            ),
            self.datePicker.bottomAnchor.constraint(
                equalTo: self.stackView.bottomAnchor,
                constant: AddTodoVCConstraint.textViewHeight
            ),
            self.datePicker.leadingAnchor.constraint(
                equalTo: self.stackView.leadingAnchor
            ),
            self.datePicker.trailingAnchor.constraint(
                equalTo: self.stackView.trailingAnchor
            )
        ])
    }

    private func setTextViewConstraints() {
        NSLayoutConstraint.activate([
            self.datePicker.topAnchor.constraint(
                equalTo: self.stackView.bottomAnchor,
                constant: AddTodoVCConstraint.textViewHeight
            ),
            self.datePicker.bottomAnchor.constraint(
                equalTo: self.stackView.bottomAnchor
            ),
            self.datePicker.leadingAnchor.constraint(
                equalTo: self.stackView.leadingAnchor
            ),
            self.datePicker.trailingAnchor.constraint(
                equalTo: self.stackView.trailingAnchor
            )
        ])
    }

// MARK: - Button Tap Actions

    @objc
    private func cancelButtonDidTap() {

    }

    @objc
    private func doneButtonDidTap() {

    }

}

extension AddTodoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = AddTodoVCScript.textViewPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
}

private enum AddTodoVCScript {
    static let title = "TODO"
    static let cancel = "Cancel"
    static let done = "Done"
    static let textFieldPlaceHolder = "Title"
    static let textViewPlaceHolder = "1000자 이내로 입력해주세요"
}

private enum AddTodoVCConstraint {
    static let spacing: CGFloat = 10
    static let stackViewPadding: CGFloat = 10
    static let stackViewBottomPadding: CGFloat = 20
    static let textFieldHeight: CGFloat = 30
    static let textViewHeight: CGFloat = 120
}
