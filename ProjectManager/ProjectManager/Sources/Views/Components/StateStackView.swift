//
//  StateStackView.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/21.
//

import UIKit

class StateStackView: UIStackView {

    private enum Style {
        static let spacing: CGFloat = 10
    }

    private var state: Task.State?

    // MARK: Views

    let stateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
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
        return tableView
    }()

    // MARK: Initializers

    init(state: Task.State) {
        super.init(arrangedSubviews: [stateView, stateTableView])
        self.state = state
        setAttributes()
        setSubviews()
        setStateLabel()
        setTaskCountLabel(as: 0)
    }

    init(state: Task.State, frame: CGRect) {
        self.state = state
        super.init(frame: frame)
        setAttributes()
        setSubviews()
        setStateLabel()
        setTaskCountLabel(as: 0)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Configure

    private func setAttributes() {
        alignment = .fill
        axis = .vertical
        distribution = .fill
        spacing = Style.spacing
    }

    func setSubviews() {
        stateView.addSubview(stateLabel)
        stateView.addSubview(taskCountLabel)

        NSLayoutConstraint.activate([
            stateLabel.leadingAnchor.constraint(equalTo: stateView.leadingAnchor, constant: 15),
            stateLabel.topAnchor.constraint(equalTo: stateView.topAnchor, constant: 10),
            stateLabel.bottomAnchor.constraint(equalTo: stateView.bottomAnchor, constant: 10),
            taskCountLabel.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: 15),
            taskCountLabel.widthAnchor.constraint(equalTo: taskCountLabel.heightAnchor),
            taskCountLabel.centerYAnchor.constraint(equalTo: stateLabel.centerYAnchor)
        ])

        addArrangedSubview(stateView)
        addArrangedSubview(stateTableView)

        NSLayoutConstraint.activate([
            stateView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
    }

    func setTaskCountLabel(as value: Int) {
        taskCountLabel.text = "\(value)"
//        taskCountLabel.layer.cornerRadius = 0.5 * taskCountLabel.bounds.width
    }

    func setStateLabel() {
        stateLabel.text = state?.rawValue.uppercased()
    }
}
