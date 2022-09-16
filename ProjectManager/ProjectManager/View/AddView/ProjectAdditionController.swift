//
//  ProjectAdditionController.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/11.
//

import UIKit

final class ProjectAdditionController: UIViewController {
    private let projectAdditionScrollView = ProjectAdditionScrollView()
    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureUI()
    }
    
    private func configureNavigationItems() {
        self.title = "TODO"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTapDoneButton)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(didTapCancelButton)
        )
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(projectAdditionScrollView)
        
        NSLayoutConstraint.activate([
            projectAdditionScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            projectAdditionScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            projectAdditionScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            projectAdditionScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func didTapDoneButton() {
        self.viewModel?.addProject(
            title: projectAdditionScrollView.scheduleTitleTextField.text!,
            body: projectAdditionScrollView.scheduleDescriptionTextView.text,
            date: projectAdditionScrollView.datePicker!.date
        )

        self.dismiss(animated: true)
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true)
    }
}
