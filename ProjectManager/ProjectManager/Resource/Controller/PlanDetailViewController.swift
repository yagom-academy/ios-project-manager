//
//  ToDoDetailViewController.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import UIKit

class PlanDetailViewController: UIViewController {
    private lazy var planDetailView = PlanDetailView(frame: view.bounds)
    private var planManager = PlanManager()
    private var plan: Plan?

    init() {
        self.planManager = PlanManager()
        do {
//            plan = try self.planManager.create(planList: &<#[Plan]#>)
        } catch {
            fatalError()
        }
        super.init(nibName: nil, bundle: nil)
    }

    init(planManager: PlanManager, id: UUID) {
        self.planManager = planManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationItem()
    }

    private func configureView() {
        view.addSubview(planDetailView)

        planDetailView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func configureNavigationItem() {
        let navigationItem = UINavigationItem(title: "TODO")

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancel(sender:)))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tappedDone(sender:)))

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton

        planDetailView.configureNavigationBar(on: navigationItem)
    }

    @objc private func tappedCancel(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @objc private func tappedDone(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
