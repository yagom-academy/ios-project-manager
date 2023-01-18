//
//  ProjectView.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/16.
//

import UIKit

final class ProjectView: UIView {
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return stackView
    }()

    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: 3, height: 5)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3.0
        textView.layer.masksToBounds = false
        textView.isScrollEnabled = false
        textView.font = UIFont.preferredFont(forTextStyle: .title1)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
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
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: 3, height: 5)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3.0
        textView.layer.masksToBounds = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
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
        addSubview(navigationBar)
        addSubview(stackView)

        stackView.addArrangedSubview(titleTextView)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(descriptionTextView)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])

        if #available(iOS 15.0, *) {
            stackView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -16).isActive = true
        } else {
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        }
    }

    func configureNavigationBar(on item: UINavigationItem) {
        navigationBar.setItems([item], animated: true)
    }

    func configure(with project: Project) {
        titleTextView.text = project.title
        descriptionTextView.text = project.description
        datePicker.date = project.dueDate
    }
}
