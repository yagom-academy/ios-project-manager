//
//  ProjectModificationController.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import UIKit

final class ProjectModificationController: UIViewController {
    private let scrollView = ContentScrollView()
    var viewModel: ContentEditable?
    var indexPath: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureUI()
        setContent()
    }

    @objc private func didTapDoneButton() {
        self.dismiss(animated: true)
    }

    @objc private func didTapEditButton() {
        guard let indexPath = indexPath,
              let title = scrollView.scheduleTitleTextField.text,
              let date = scrollView.datePicker?.date else {
            return
        }

        self.viewModel?.edit(
            indexPath: indexPath,
            title: title,
            body: scrollView.scheduleDescriptionTextView.text,
            date: date
        )
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
        self.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setContent() {
        guard let indexPath = indexPath,
              let data = viewModel?.fetch(indexPath) else {
            return
        }

        scrollView.setContent(data: data)
    }
}
