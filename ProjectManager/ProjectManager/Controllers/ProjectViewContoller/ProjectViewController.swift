//
//  ProjectViewController.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import UIKit

final class ProjectViewController: UIViewController {
    enum ViewMode {
        case add
        case edit
    }

    private var mode: ViewMode
    private var project: Project
    var completion: ((Project) -> ())?
    private lazy var projectView: ProjectView  = {
        let view = ProjectView(frame: view.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureNavigationItem()
    }

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

    private func configureView() {
        view.addSubview(projectView)

        projectView.configure(with: project)
    }

    private func touchUpRightBarButton() {
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
