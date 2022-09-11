//
//  ProjectAdditionController.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/11.
//

import UIKit

final class ProjectAdditionController: UIViewController {
    private let projectAdditionScrollView = ProjectAdditionScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationItems()
        configureUI()
    }
    
    private func configNavigationItems() {
        self.title = "TODO"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTappedDoneButton)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(didTappedCancelButton)
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
    
    @objc private func didTappedDoneButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTappedCancelButton() {
        self.dismiss(animated: true)
    }
}
