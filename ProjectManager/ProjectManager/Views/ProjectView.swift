//
//  ProjectView.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/16.
//

import UIKit

final class ProjectView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.placeholder = "제목 없음"
        return textField
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.backgroundColor = .white
        return datePicker
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        return textView
    }()

    var isTexting: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .systemBackground
        addSubview(stackView)

        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(descriptionTextView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])

        if #available(iOS 15.0, *) {
            stackView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor).isActive = true
        } else {
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }

    func configure(with project: Project) {
        titleTextField.text = project.title
        descriptionTextView.text = project.description
        datePicker.date = project.dueDate
    }
}
