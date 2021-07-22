//
//  StateStackView.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/21.
//

import UIKit

class StateStackView: UIStackView {

    private enum Style {
        static let spacing: CGFloat = 3
    }

    // MARK: Properties

    private var state: Task.State?

    // MARK: Views

    let stateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()

    let stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    let taskCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.backgroundColor = .label
        label.textColor = .systemBackground
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        return label
    }()

    let stateTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        return tableView
    }()

    // MARK: Initializers

    init(state: Task.State, delegate: UITableViewDataSource) {
        super.init(frame: .zero)
        stateTableView.dataSource = delegate
        self.state = state
        setAttributes()
        setSubviews()
        setStateLabel()
        setTaskCountLabel(as: 0)
        stateTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Configures

    private func setAttributes() {
        alignment = .fill
        axis = .vertical
        backgroundColor = .systemGray4
        distribution = .fill
        spacing = Style.spacing
    }

    func setSubviews() {
        stateView.addSubview(stateLabel)
        stateView.addSubview(taskCountLabel)

        NSLayoutConstraint.activate([
            stateLabel.leadingAnchor.constraint(equalTo: stateView.leadingAnchor, constant: 10),
            stateLabel.topAnchor.constraint(equalTo: stateView.topAnchor, constant: 10),
            stateLabel.bottomAnchor.constraint(equalTo: stateView.bottomAnchor, constant: -10),
            taskCountLabel.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: 10),
            taskCountLabel.widthAnchor.constraint(equalTo: taskCountLabel.heightAnchor),
            taskCountLabel.centerYAnchor.constraint(equalTo: stateLabel.centerYAnchor)
        ])

        addArrangedSubview(stateView)
        addArrangedSubview(stateTableView)
    }

    func setTaskCountLabel(as value: Int) {
        taskCountLabel.text = "\(value)"
    }

    func setStateLabel() {
        stateLabel.text = state?.rawValue.uppercased()
    }
}
