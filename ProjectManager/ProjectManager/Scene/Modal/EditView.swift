//
//  EditView.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/11.
//

import UIKit

class EditView: UIView {

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.date = Date()
        datePicker.datePickerMode = .date

        let locale = Locale.preferredLanguages.first ?? Locale.current.identifier
        datePicker.locale = Locale(identifier: locale)

        return datePicker
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = EditViewConstraint.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.addConstraint(
            textField.heightAnchor.constraint(equalToConstant: EditViewConstraint.textFieldHeight)
        )
        textField.placeholder = EditViewScript.textFieldPlaceHolder
        textField.font = EditViewFont.textField
        textField.styleWithShadow()

        return textField
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.font = EditViewFont.textView
        textView.styleWithShadow()

        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        self.configureStackView()
    }

    private func configureStackView() {
        self.addSubview(self.stackView)
        self.setStackViewConstraints()
        self.addViewsToStackView()
    }

    private func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: EditViewConstraint.stackViewPadding
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -(EditViewConstraint.stackViewBottomPadding)
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: EditViewConstraint.stackViewPadding
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -(EditViewConstraint.stackViewPadding)
            )
        ])
    }

    private func addViewsToStackView() {
        self.stackView.addArrangedSubview(self.textField)
        self.stackView.addArrangedSubview(self.datePicker)
        self.stackView.addArrangedSubview(self.textView)
    }
}

// MARK: - Magic Numbers

extension EditView {

    private enum EditViewScript {

        static let textFieldPlaceHolder = "Title"
    }

    private enum EditViewConstraint {

        static let spacing: CGFloat = 10
        static let stackViewPadding: CGFloat = 10
        static let stackViewBottomPadding: CGFloat = 20
        static let textFieldHeight: CGFloat = 36
    }

    private enum EditViewFont {

        static let textField: UIFont = UIFont.preferredFont(for: .body, weight: .regular)
        static let textView: UIFont = UIFont.preferredFont(for: .body, weight: .thin)
    }
}
