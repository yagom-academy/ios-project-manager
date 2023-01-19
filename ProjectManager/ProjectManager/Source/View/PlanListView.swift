//
//  PlanListView.swift
//  ProjectManager
//
//  Created by som on 2023/01/16.
//

import UIKit

final class PlanListView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.backgroundColor = .systemGray6
        return stackView
    }()

    lazy var toDoTableView = PlanTableView(frame: .zero, style: .insetGrouped)
    lazy var doingTableView = PlanTableView(frame: .zero, style: .insetGrouped)
    lazy var doneTableView = PlanTableView(frame: .zero, style: .insetGrouped)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        addSubview(stackView)

        stackView.addArrangedSubview(toDoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
