//
//  ProjectViewController.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import UIKit

final class ProjectViewController: UIViewController {
    // MARK: Properties
    enum ViewMode {
        case add
        case edit
    }

    private var mode: ViewMode
    private var project: Project
    var completion: ((Project) -> ())?
    lazy var projectView: ProjectView  = {
        let view = ProjectView(frame: view.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureNavigationItem()

        // 15버전은 keyboardLayoutGuide 사용
        if #unavailable(iOS 15.0) {
            addKeyboardNotifications()
        }
    }

    // MARK: Initialization
    init(with project: Project = Project(),
         mode: ViewMode = .add,
         completion: ((Project) -> ())? = nil) {
        self.project = project
        self.mode = mode
        self.completion = completion

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func configureView() {
        view.addSubview(projectView)

        projectView.descriptionTextView.delegate = self
        projectView.configure(with: project)
    }

    private func fetchProjectViewData() {
        project.title = projectView.titleTextView.text
        project.description = projectView.descriptionTextView.text
        project.dueDate = projectView.datePicker.date
    }

    private func touchUpRightBarButton() {
        fetchProjectViewData()
        completion?(project)
        
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

    private func configureNavigationItem() {
        let navigationItem = UINavigationItem(title: "TODO")
        let cancelAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }

        let cancelButton = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = makeRightBarButton()

        projectView.configureNavigationBar(on: navigationItem)
    }
}

// MARK: textView Delegate
extension ProjectViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)

        return changedText.count <= 1000
    }
}
