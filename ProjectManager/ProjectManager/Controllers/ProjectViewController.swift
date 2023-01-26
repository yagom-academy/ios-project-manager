//
//  ProjectViewController.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/17.
//

import UIKit

final class ProjectViewController: UIViewController {
    // MARK: Properties
    enum ViewMode {
        case add
        case edit
    }

    private let projectView: ProjectView  = {
        let view = ProjectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let mode: ViewMode
    private weak var delegate: ProjectDelegate?
    private var project: Project

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureConstraints()
        configureNavigationBar()
        configureDelegate()

        // iOS 15 미만 노티피게이션, 이상 keyboardLayoutGuide
        if #unavailable(iOS 15.0) {
            addKeyboardNotifications()
        }
    }

    // MARK: Initialization
    init(with project: Project,
         mode: ViewMode,
         delegate: ProjectDelegate?) {
        self.project = project
        self.mode = mode
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configure View
    private func configureView() {
        view.addSubview(projectView)

        view.backgroundColor = .systemBackground
        projectView.configure(with: project)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            projectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            projectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    // MARK: Configure NavigationBar
    private func fetchProjectViewData() {
        project.title = projectView.title
        project.description = projectView.projectDescription
        project.dueDate = projectView.dueDate
    }

    private func touchUpRightBarButton() {
        fetchProjectViewData()
        delegate?.update(project: project)
        
        dismiss(animated: true, completion: nil)
    }

    private func makeRightBarButton() -> UIBarButtonItem {
        let rightButtonAction = UIAction { [weak self] _ in
            self?.touchUpRightBarButton()
        }

        switch mode {
        case .add:
            return UIBarButtonItem(systemItem: .done, primaryAction: rightButtonAction)
        case .edit:
            return UIBarButtonItem(systemItem: .edit, primaryAction: rightButtonAction)
        }
    }

    private func configureNavigationBar() {
        navigationItem.title = "TODO"
        navigationItem.scrollEdgeAppearance?.backgroundColor = .gray

        let cancelAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }

        let cancelButton = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = makeRightBarButton()
    }

    // MARK: Configure Delegate
    private func configureDelegate() {
        projectView.configureTextFieldDelegate(by: self)
        projectView.configureTextViewDelegate(by: self)
    }
}

// MARK: keyboard notification
extension ProjectViewController {
    @objc private func keyboardWillShow(_ notification: NSNotification){
        if !projectView.isTexting,
           let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            projectView.addDescriptionTextViewBottomContentInset(keyboardHeight)
            projectView.isTexting = true
        }
    }

    @objc private func keyboardWillHide(_ notification: NSNotification){
        if projectView.isTexting {
            projectView.resetDescriptionTextViewBottomContentInset()
            projectView.isTexting = false
        }
    }

    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: TextView Delegate
extension ProjectViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)

        return changedText.count <= 1000
    }
}

// MARK: TextField Delegate
extension ProjectViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
