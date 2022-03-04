//
//  EditViewController.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import UIKit

class EditViewController: UIViewController {

// MARK: - View Components

    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = EditVCScript.cancel
        button.target = self
        button.action = #selector(cancelButtonDidTap)

        return button
    }()

    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = EditVCScript.done
        button.target = self
        button.action = #selector(doneButtonDidTap)

        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = EditVCConstraint.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.addConstraint(
            textField.heightAnchor.constraint(equalToConstant: EditVCConstraint.textFieldHeight)
        )
        textField.placeholder = EditVCScript.textFieldPlaceHolder
        textField.font = EditVCFont.textField
        textField.styleWithShadow()

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
        textView.font = EditVCFont.textView
        textView.styleWithShadow()

        return textView
    }()

// MARK: - Override Method(s)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpController()
        self.view.backgroundColor = EditVCColor.background
    }

// MARK: - SetUp Controller

    private func setUpController() {
        self.configureStackView()
        self.configureNavigationBar()
        self.setUpTextView()
    }

    private func setUpTextView() {
        self.textView.delegate = self
        self.textView.text = EditVCScript.textViewPlaceHolder
        self.textView.textColor = EditVCColor.placeHolderTextColor
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
        self.title = EditVCScript.title
        self.navigationItem.leftBarButtonItem = self.cancelButton
        self.navigationItem.rightBarButtonItem = self.doneButton
    }

// MARK: - add View Constraints

    private func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: EditVCConstraint.stackViewPadding
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: -(EditVCConstraint.stackViewBottomPadding)
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                constant: EditVCConstraint.stackViewPadding
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                constant: -(EditVCConstraint.stackViewPadding)
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
                constant: EditVCConstraint.textFieldHeight
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
                constant: EditVCConstraint.textFieldHeight
            ),
            self.datePicker.bottomAnchor.constraint(
                equalTo: self.stackView.bottomAnchor,
                constant: EditVCConstraint.textViewHeight
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
                constant: EditVCConstraint.textViewHeight
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
        self.dismiss(animated: true, completion: nil)
    }

    @objc
    private func doneButtonDidTap() {

    }
}

extension EditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == EditVCColor.placeHolderTextColor {
            textView.text = nil
            textView.textColor = EditVCColor.defaultTextColor
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = EditVCScript.textViewPlaceHolder
            textView.textColor = EditVCColor.placeHolderTextColor
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textViewText = textView.text else {
            return true
        }

        let newLength = textViewText.count + text.count - range.length

        return newLength <= 1000
    }
}

private enum EditVCScript {
    static let title = "TODO"
    static let cancel = "Cancel"
    static let done = "Done"
    static let textFieldPlaceHolder = "Title"
    static let textViewPlaceHolder = "1000자 이내로 입력해주세요"
}

private enum EditVCConstraint {
    static let spacing: CGFloat = 10
    static let stackViewPadding: CGFloat = 10
    static let stackViewBottomPadding: CGFloat = 20
    static let textFieldHeight: CGFloat = 36
    static let textViewHeight: CGFloat = 100
}

private enum EditVCColor {
    static let background: UIColor = .white
    static let placeHolderTextColor: UIColor = .lightGray
    static let defaultTextColor: UIColor = .black
}

private enum EditVCFont {
    static let textField: UIFont = UIFont.preferredFont(for: .body, weight: .regular)
    static let textView: UIFont = UIFont.preferredFont(for: .body, weight: .thin)
}
