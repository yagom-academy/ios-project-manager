//
//  ToDoDetailViewController.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import UIKit

class PlanDetailViewController: UIViewController {
    private lazy var planDetailView = PlanDetailView(frame: view.bounds)

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
