//
//  ProjectManager - PlanListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class PlanListViewController: UIViewController {
    typealias Text = ProjectConstant.Text
    typealias Style = ProjectConstant.Style

    private var planManager: PlanManager
    private let viewModel: PlanListViewModel
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.spacing = Style.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    init(planManger: PlanManager = ProjectManager.shared,
         viewModel: PlanListViewModel = ProjectListViewModel()) {
        self.planManager = planManger
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        configurePlanManger()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIComponent()
    }

    private func configurePlanManger() {
        planManager.outputPort = viewModel
    }

    private func configureUIComponent() {
        configureNavigationBar()
        configureViewHierarchy()
        configureLayoutConstraint()
    }

    private func configureNavigationBar() {
        navigationItem.title = Text.navigationTitle
        navigationItem.rightBarButtonItem = addPlanButton()
    }

    private func configureViewHierarchy() {
        view.addSubview(stackView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: Style.stackViewBottomInset),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    private func presentPlanView(viewModel: PlanViewModel) {
        let planViewController = PlanViewController(viewModel: viewModel)

        planViewController.modalPresentationStyle = .formSheet
        present(planViewController, animated: true)
    }

    private func addPlanAction() -> UIAction {
        let action = UIAction { _ in
            self.presentPlanView(viewModel: ProjectViewModel())
        }

        return action
    }

    private func addPlanButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(systemItem: .add, primaryAction: addPlanAction())

        return button
    }
}
