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

        static let editButtonTitle: String = "Edit"
        static let doneButtonTitle: String = "Done"
        static let cancelButtonTitle: String = "Cancel"

        static let bodyTextViewBackgroundColor: UIColor = .systemBackground
        static let bodyTextViewShadowColor: UIColor = .systemGray3
        static let bodyTextViewShadowRadius: CGFloat = 4
        static let bodyTextViewShadowOpacity: Float = 1
        static let bodyTextViewShadowOffset: CGSize = CGSize(width: 0, height: 3)
        static let bodyTextViewTextStyle: UIFont.TextStyle = .title3

        static let maxBodyLengthAlertTitle: String = "최대 글자수 초과"
        static let maxBodyLengthAlertMessage: String = "\(Style.bodyLengthLimit)자 이하로 작성해주세요."
        static let maxBodyLengthAlertPresentTime: TimeInterval = 0.5
        static let bodyLengthLimit: Int = 1_000

        static let titleRequiredAlertTitle: String = "제목이 빠졌어요 😊"
        static let titleRequiredAlertMessage: String = "제목을 적어주세요."

        static let okActionTitle: String = "확인"

        static let contentStackViewInset: CGFloat = 20
    }

    enum EditMode {
        case add, update
    }

    // MARK: Properties

    private var editMode: EditMode?
    private var viewModel: TaskEditViewModel = TaskEditViewModel()
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

    private let titleTextField = TaskEditTitleTextField()

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
        textView.layer.shadowRadius = Style.bodyTextViewShadowRadius
        textView.layer.shadowColor = Style.bodyTextViewShadowColor.cgColor
        textView.layer.shadowOpacity = Style.bodyTextViewShadowOpacity
        textView.layer.shadowOffset = Style.bodyTextViewShadowOffset
        textView.font = UIFont.preferredFont(forTextStyle: Style.bodyTextViewTextStyle)
        textView.clipsToBounds = false
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

        self.modalTransitionStyle = .flipHorizontal
        self.editMode = editMode
        self.viewModel.task = task?.task
        self.viewModel.indexPath = task?.indexPath

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
        bindWithViewModel()
    }

    // MARK: Configure

    private func setAttributes() {
        if let state = viewModel.task?.state {
            title = "\(state)".uppercased()
        } else {
            title = Style.defaultTitle
        }
        view.backgroundColor = .systemBackground
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
                                                                        constant: -Style.contentStackViewInset)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true

        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor,
                                                      constant: Style.contentStackViewInset),
            contentStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor,
                                                       constant: -Style.contentStackViewInset),
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor,
                                                  constant: Style.contentStackViewInset),
            contentStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor,
                                                    constant: -Style.contentStackViewInset * 2),
            contentStackView.heightAnchor.constraint(
                greaterThanOrEqualTo: contentScrollView.frameLayoutGuide.heightAnchor,
                constant: -Style.contentStackViewInset * 2)
        ])
    }

    private func configure() {
        guard editMode == .update,
              let task = viewModel.task else { return }

        titleTextField.text = task.title
        dueDatePicker.date = task.dueDate
        bodyTextView.text = task.body
        bodyTextView.delegate = self
        toggleEditState()
    }

    private func bindWithViewModel() {
        viewModel.updated = { (indexPath, task) -> Void in
            self.delegate?.taskWillUpdate(task, indexPath)
        }

        viewModel.created = { (task) -> Void in
            self.delegate?.taskWillAdd(task)
        }
    }

    private func toggleEditState() {
        titleTextField.isUserInteractionEnabled.toggle()
        dueDatePicker.isUserInteractionEnabled.toggle()
        bodyTextView.isEditable.toggle()
    }

    // MARK: Button Actions

    @objc private func editButtonTapped() {
        navigationItem.leftBarButtonItem = cancelButton
        toggleEditState()
    }

    @objc private func doneButtonTapped() {
        guard let title = titleTextField.text,
              let body = bodyTextView.text else { return }

        guard !title.isEmpty else {
            showTitleRequiredAlert()
            return
        }

        switch editMode {
        case .add:
            viewModel.create(title: title, dueDate: dueDatePicker.date, body: body)
        case .update:
            viewModel.update(title: title, dueDate: dueDatePicker.date, body: body)
        default:
            break
        }

        dismiss(animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }

    // MARK: Alerts

    private func showMaxBodyLengthAlert() {
        let alert = UIAlertController(title: Style.maxBodyLengthAlertTitle,
                                      message: Style.maxBodyLengthAlertMessage,
                                      preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Style.maxBodyLengthAlertPresentTime) {
            alert.dismiss(animated: true)
        }
    }

    private func showTitleRequiredAlert() {
        let alert = UIAlertController(title: Style.titleRequiredAlertTitle,
                                      message: Style.titleRequiredAlertMessage,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: Style.okActionTitle, style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    // MARK: Configure View with Keyboard Notification

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: keyboardFrame.height, right: .zero)
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
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
