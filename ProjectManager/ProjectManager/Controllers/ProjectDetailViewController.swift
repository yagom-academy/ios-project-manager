//
//  ProjectDetailViewController.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import UIKit

class ProjectDetailViewController: UIViewController {
    // MARK: - Properties
    private let titleTextField = TitleTextField()
    private let dueDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    private let descriptionShadowView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = Constants.borderWidth
        view.addShadow()
        return view
    }()
    private let descriptionTextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.adjustsFontForContentSizeCategory = true
        return textView
    }()
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    private let navigationTitle: String
    private var project: Project
    private var keyboardConstraints: NSLayoutConstraint?

    // MARK: - Configure
    init(navigationTitle: String, project: Project) {
        self.navigationTitle = navigationTitle
        self.project = project
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = ProjectColor.defaultBackground.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureHierarchy()
        updateProjectDetailViewsData(project)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }

    private func configureNavigationItem() {
        navigationItem.title = navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: nil)
    }

    private func configureHierarchy() {
        descriptionShadowView.addSubview(descriptionTextView)
        [titleTextField, dueDatePicker, descriptionShadowView].forEach(stackView.addArrangedSubview(_:))
        view.addSubview(stackView)

        let spacing = Constants.defaultSpacing
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionShadowView.topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionShadowView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionShadowView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: descriptionShadowView.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -spacing)
        ])
    }
}

// MARK: - Project Data
extension ProjectDetailViewController {
    private func updateProjectDetailViewsData(_ project: Project) {
        titleTextField.text = project.title
        dueDatePicker.date = project.dueDate
        descriptionTextView.text = project.description
    }
}

// MARK: - Keyboard
extension ProjectDetailViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard descriptionTextView.isFirstResponder else { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        keyboardConstraints?.constant = -keyboardHeight
    }

    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        keyboardConstraints?.constant = -Constants.defaultSpacing
    }
}
