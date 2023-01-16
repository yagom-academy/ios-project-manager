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
    private var projectViewModel: ProjectViewModel
    private let isAdding: Bool
    private let onChange: (Project?) -> Void
    private var keyboardConstraints: NSLayoutConstraint?

    // MARK: - Configure
    init(navigationTitle: String, projectViewModel: ProjectViewModel, isAdding: Bool, onChange: @escaping (Project?) -> Void) {
        self.navigationTitle = navigationTitle
        self.projectViewModel = projectViewModel
        self.isAdding = isAdding
        self.onChange = onChange
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
        configureSubViews()
        if isAdding {
            prepareForEditing()
        } else {
            prepareForeViewing()
        }
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
                                                            action: #selector(doneEditing))
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
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing)
        ])
        keyboardConstraints = stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -spacing)
        keyboardConstraints?.isActive = true
    }

    private func configureSubViews() {
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange), for: .editingChanged)
        dueDatePicker.addTarget(self, action: #selector(dueDatePickerDidChange), for: .valueChanged)
        descriptionTextView.delegate = self
    }
}

// MARK: - Project Data
extension ProjectDetailViewController {
    private func updateProjectDetailViewsData(_ project: Project) {
        titleTextField.text = projectViewModel.project.title
        dueDatePicker.date = projectViewModel.project.dueDate
        descriptionTextView.text = projectViewModel.project.description
    }
}

// MARK: - Actions
extension ProjectDetailViewController {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        titleTextField.isUserInteractionEnabled = editing
        dueDatePicker.isUserInteractionEnabled = editing
        descriptionTextView.isUserInteractionEnabled = editing
    }

    @objc
    private func prepareForEditing() {
        self.isEditing = true
        projectViewModel.editingProject = projectViewModel.project
        if isAdding {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                               target: self,
                                                               action: #selector(cancelAdding))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                               target: self,
                                                               action: #selector(prepareForeViewing))
        }
        updateProjectDetailViewsData(projectViewModel.project)
    }

    @objc
    private func prepareForeViewing() {
        self.isEditing = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                           target: self,
                                                           action: #selector(prepareForEditing))
        updateProjectDetailViewsData(projectViewModel.project)
    }

    @objc
    private func doneEditing() {
        if isEditing {
            onChange(projectViewModel.editingProject)
        } else {
            onChange(nil)
            dismiss(animated: true)
        }
    }

    @objc
    private func cancelAdding() {
        dismiss(animated: true)
    }

    @objc
    private func titleTextFieldDidChange(_ sender: UITextField) {
        projectViewModel.editingProject.title = sender.text ?? ""
    }

    @objc
    private func dueDatePickerDidChange(_ sender: UIDatePicker) {
        projectViewModel.editingProject.dueDate = sender.date
    }
}

extension ProjectDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        projectViewModel.editingProject.description = textView.text ?? ""
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text else { return true }
        let newTextLength = currentText.count + text.count - range.length
        return newTextLength <= Constants.descriptionTextViewMaxTextLength
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
