//
//  ProjectAdditionController.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/11.
//

import UIKit

final class ProjectAdditionController: UIViewController {
    private let scrollView = ContentScrollView()
    var viewModel: ContentAddible?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureUI()
    }

    @objc private func didTapDoneButton() {
        guard let title = scrollView.scheduleTitleTextField.text,
              let date = scrollView.datePicker?.date else {
            return
        }

        self.viewModel?.addContent(
            title: title,
            body: scrollView.scheduleDescriptionTextView.text,
            date: date
        )

        self.dismiss(animated: true)
    }

    @objc private func didTapCancelButton() {
        self.dismiss(animated: true)
    }
    
    private func configureNavigationItems() {
        self.title = ProjectStatus.todo
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
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
