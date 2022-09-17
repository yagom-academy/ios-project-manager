//
//  ProjectModificationController.swift
//  ProjectManager
//
//  Created by 전민수 on 2022/09/17.
//

import UIKit

final class ProjectModificationController: UIViewController {
    private let projectAdditionScrollView = ProjectAdditionScrollView()
    var viewModel: Editable?
    var indexPath: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureUI()
        setContent()
    }
    
    private func setContent() {
        guard let indexPath = indexPath,
              let data = viewModel?.fetch(indexPath) else {
            return
        }
        
        projectAdditionScrollView.setContent(data: data)
    }
    
    private func configureNavigationItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTapDoneButton)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(didTapEditButton)
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
        self.dismiss(animated: true)
    }

    @objc private func didTapEditButton() {
        guard let indexPath = indexPath,
              let title = projectAdditionScrollView.scheduleTitleTextField.text,
              let date = projectAdditionScrollView.datePicker?.date else {
            return
        }

        
        viewModel?.edit(
            indexPath: indexPath,
            title: title,
            body: projectAdditionScrollView.scheduleDescriptionTextView.text,
            date: date
        )
    }
}
