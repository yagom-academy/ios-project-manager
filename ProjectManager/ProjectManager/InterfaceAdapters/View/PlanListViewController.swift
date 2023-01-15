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
    }

    private func configurePlanManger() {
        planManager.outputPort = viewModel
    }
}
