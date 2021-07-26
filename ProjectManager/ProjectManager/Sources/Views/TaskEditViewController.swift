//
//  TaskEditViewController.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/23.
//

import UIKit

final class TaskEditViewController: UIViewController {

    private enum Style {
        static let defaultTitle: String = "TODO"
        static let titleTextFieldPlaceholder: String = "Title"
        static let editButtonTitle: String = "Edit"
        static let doneButtonTitle: String = "Done"
        static let cancelButtonTitle: String = "Cancel"
        static let bodyLengthLimit: Int = 1_000
    }

    enum EditMode {
        case add, update
    }

    // MARK: Properties

    private var editMode: EditMode?
    private var taskEditViewModel: TaskEditViewModel = TaskEditViewModel()
    weak var delegate: TaskEditViewControllerDelegate?

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
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
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
        textView.isScrollEnabled = false
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

    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: Initializers

    init?(editMode: EditMode, task: (indexPath: IndexPath, task: Task)? = nil) {
        guard (editMode == .add && task == nil) ||
                (editMode == .update && task != nil) else { return nil }
        super.init(nibName: nil, bundle: nil)

        self.editMode = editMode
        self.taskEditViewModel.task = task?.task
        self.taskEditViewModel.indexPath = task?.indexPath

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        setNavigationBarItems()
        setSubviews()
        setLayouts()
        configure()

        taskEditViewModel.updated = { (indexPath, task) -> Void in
            self.delegate?.taskWillUpdate(task, indexPath)
        }

        taskEditViewModel.created = { (task) -> Void in
            self.delegate?.taskWillAdd(task)
        }
    }

    // MARK: Configure

    private func setAttributes() {
        if let state = taskEditViewModel.task?.state {
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
        contentScrollView.addSubview(contentStackView)
        view.addSubview(contentScrollView)
    }

    private func setLayouts() {
        setContentScrollViewLayout()
        setContentStackViewLayout()
    }

    private func setContentScrollViewLayout() {
        NSLayoutConstraint.activate([
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setContentStackViewLayout() {
        let bottomConstraint = contentStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor,
                                                                        constant: -20)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true

        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: -20),
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 20),
            contentStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -40),
            contentStackView.heightAnchor.constraint(
                greaterThanOrEqualTo: contentScrollView.frameLayoutGuide.heightAnchor,
                constant: -40)
        ])
    }

    private func setNavigationBarItems() {
        switch editMode {
        case .add:
            navigationItem.leftBarButtonItem = cancelButton
        case .update:
            navigationItem.leftBarButtonItem = editButton
        case .none:
            break
        }
        navigationItem.rightBarButtonItem = doneButton
    }

    private func configure() {
        guard editMode == .update,
              let task = taskEditViewModel.task else { return }

        titleTextField.text = task.title
        dueDatePicker.date = task.dueDate
        bodyTextView.text = task.body
        bodyTextView.delegate = self
        toggleEditState()
    }

    private func toggleEditState() {
        titleTextField.isUserInteractionEnabled.toggle()
        dueDatePicker.isUserInteractionEnabled.toggle()
        bodyTextView.isEditable.toggle()
    }

    // MARK: Button Actions

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + 6, right: 0)
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func editButtonTapped() {
        navigationItem.leftBarButtonItem = cancelButton
        toggleEditState()
    }

    @objc private func doneButtonTapped() {
        guard let title = titleTextField.text, let body = bodyTextView.text else { return }

        switch editMode {
        case .add:
            taskEditViewModel.create(title: title, dueDate: dueDatePicker.date, body: body)
        case .update:
            taskEditViewModel.update(title: title, dueDate: dueDatePicker.date, body: body)
        default:
            break
        }

        dismiss(animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }

    private func showMaxBodyLengthAlert() {
        let alert = UIAlertController(title: "최대 글자수 초과",
                                      message: "\(Style.bodyLengthLimit)자 이하로 작성해주세요.",
                                      preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            alert.dismiss(animated: true)
        }
    }
}

// MARK: - UITextViewDelegate

extension TaskEditViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let originText: String = textView.text ?? ""
        let isUnderLimit: Bool = originText.count + (text.count - range.length) <= Style.bodyLengthLimit
        if !isUnderLimit {
            showMaxBodyLengthAlert()
        }

        return isUnderLimit
    }
}
