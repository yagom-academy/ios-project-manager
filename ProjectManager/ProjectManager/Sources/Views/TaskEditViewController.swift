//
//  TaskEditViewController.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/23.
//

import UIKit

final class TaskEditViewController: UIViewController {

    private enum Style {
        static let defaultTitle = "TODO"
        static let titleTextFieldPlaceholder = "Title"
        static let editButtonTitle = "Edit"
        static let doneButtonTitle = "Done"
        static let cancelButtonTitle = "Cancel"
    }

    // MARK: Properties

    var task: Task? {
        didSet {
            toggleEditMode()
        }
    }

    // MARK: Views

    private lazy var editButton = UIBarButtonItem(title: Style.editButtonTitle,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(editButtonTapped))
    private lazy var doneButton = UIBarButtonItem(title: Style.doneButtonTitle,
                                                  style: .done, target: self,
                                                  action: #selector(doneButtonTapped))
    private lazy var cancelButton = UIBarButtonItem(title: Style.cancelButtonTitle,
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(cancelButtonTapped))

    private let titleTextField: TaskEditTitleTextField = {
        let textField = TaskEditTitleTextField()
        textField.placeholder = Style.titleTextFieldPlaceholder
        textField.backgroundColor = .systemBackground
        textField.layer.shadowRadius = 4
        textField.layer.shadowColor = UIColor.systemGray3.cgColor
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.font = UIFont.preferredFont(forTextStyle: .title1)
        return textField
    }()

    private let dueDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()

    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.layer.shadowRadius = 4
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOpacity = 1
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.clipsToBounds = false
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        return textView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        setNavigationBarItems()
        setSubviews()
        setLayouts()
        configure()
    }

    // MARK: Configure

    private func setAttributes() {
        if let state = task?.state {
            title = "\(state)".uppercased()
        } else {
            title = Style.defaultTitle
        }
        view.backgroundColor = .systemBackground
    }

    private func setSubviews() {
        contentStackView.addArrangedSubview(titleTextField)
        contentStackView.addArrangedSubview(dueDatePicker)
        contentStackView.addArrangedSubview(bodyTextView)
        view.addSubview(contentStackView)
    }

    private func setLayouts() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    private func setNavigationBarItems() {
        navigationItem.leftBarButtonItem = editButton
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc private func editButtonTapped() {
        navigationItem.leftBarButtonItem = cancelButton
        toggleEditMode()
    }

    @objc private func doneButtonTapped() {
        dismiss(animated: true) {

        }
    }
    @objc private func cancelButtonTapped() {
        toggleEditMode()
        navigationItem.leftBarButtonItem = editButton
    }

    private func configure() {
        guard let task = task else { return }
        titleTextField.text = task.title
        bodyTextView.text = task.body
    }

    private func toggleEditMode() {
        titleTextField.isUserInteractionEnabled.toggle()
        dueDatePicker.isUserInteractionEnabled.toggle()
        bodyTextView.isEditable.toggle()
    }
}
