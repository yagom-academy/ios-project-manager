//
//  ProjectManager - PlanListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class PlanListViewController: UIViewController {

    private var planManager: PlanManager
    private let viewModel: PlanListViewModel

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

        configureNavigationBar()
    }

    private func configurePlanManger() {
        planManager.outputPort = viewModel
    }

    private func configureNavigationBar() {
        navigationItem.title = ProjectConstant.Text.navigationTitle
        navigationItem.rightBarButtonItem = addPlanButton()
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
