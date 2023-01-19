//
//  PlanDetailView.swift
//  ProjectManager
//
//  Created by som on 2023/01/16.
//

import UIKit

final class PlanDetailView: UIView {
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = LayoutConstraint.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return stackView
    }()

    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = LayoutConstraint.borderWidth
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: LayoutConstraint.shadowOffsetWidth,
                                             height: LayoutConstraint.shadowOffsetHeight)
        textView.layer.shadowOpacity = LayoutConstraint.shadowOpacity
        textView.layer.shadowRadius = LayoutConstraint.shadowRadius
        textView.layer.masksToBounds = false
        textView.isScrollEnabled = false
        textView.font = UIFont.preferredFont(forTextStyle: .title1)
        textView.textContainerInset = UIEdgeInsets(top: LayoutConstraint.insetSize,
                                                   left: LayoutConstraint.insetSize,
                                                   bottom: LayoutConstraint.insetSize,
                                                   right: LayoutConstraint.insetSize)
        return textView
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        return datePicker
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = LayoutConstraint.borderWidth
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: LayoutConstraint.shadowOffsetWidth,
                                             height: LayoutConstraint.shadowOffsetHeight)
        textView.layer.shadowOpacity = LayoutConstraint.shadowOpacity
        textView.layer.shadowRadius = LayoutConstraint.shadowRadius
        textView.layer.masksToBounds = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textContainerInset = UIEdgeInsets(top: LayoutConstraint.insetSize,
                                                   left: LayoutConstraint.insetSize,
                                                   bottom: LayoutConstraint.insetSize,
                                                   right: LayoutConstraint.insetSize)
        textView.keyboardDismissMode = .onDrag
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
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

            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: LayoutConstraint.topConstant),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstraint.leadingConstant),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: LayoutConstraint.trailingConstant),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: LayoutConstraint.bottomConstant),

            titleTextView.heightAnchor.constraint(equalToConstant: LayoutConstraint.heightConstant)
        ])
    }

    func configureNavigationBar(on item: UINavigationItem) {
        navigationBar.setItems([item], animated: true)
    }

    func sendUserPlan() -> (title: String, description: String, deadline: Date) {
        return (titleTextView.text, descriptionTextView.text, datePicker.date)
    }

    func configureTextView(title: String, description: String, deadline: Date, isEditable: Bool) {
        titleTextView.isEditable = isEditable
        descriptionTextView.isEditable = isEditable
        datePicker.isEnabled = isEditable

        titleTextView.text = title
        descriptionTextView.text = description
        datePicker.date = deadline
    }

    func setPlaceholder() {
        titleTextView.text = PlanText.title
        titleTextView.textColor = .systemGray3
        descriptionTextView.text = PlanText.description
        descriptionTextView.textColor = .systemGray3
    }

    func setTextViewDelegate(_ delegate: UITextViewDelegate) {
        titleTextView.delegate = delegate
        descriptionTextView.delegate = delegate
    }

    private enum LayoutConstraint {
        static let spacing: CGFloat = 8
        static let borderWidth: CGFloat = 1.0
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 3.0
        static let shadowOffsetWidth: CGFloat = 3
        static let shadowOffsetHeight: CGFloat = 5
        static let insetSize: CGFloat = 8
        static let topConstant: CGFloat = 8
        static let leadingConstant: CGFloat = 16
        static let trailingConstant: CGFloat = -16
        static let bottomConstant: CGFloat = -16
        static let heightConstant: CGFloat = 50
    }
}
