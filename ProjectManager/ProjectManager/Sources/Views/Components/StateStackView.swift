//
//  StateStackView.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/21.
//

import UIKit

final class StateStackView: UIStackView {

    private enum Style {
        static let backgroundColor: UIColor = .systemGray4
        static let spacing: CGFloat = 3
        static let stateInset: CGFloat = 10

        static let stateViewBackgroundColor: UIColor = .systemGray6

        static let stateTextStyle: UIFont.TextStyle = .largeTitle

        static let taskCountBackgroundColor: UIColor = .label
        static let taskCountCornerRadius: CGFloat = 13
        static let taskCountInitialText: String = "0"
        static let taskCountTextColor: UIColor = .systemBackground
        static let taskCountTextStyle: UIFont.TextStyle = .title2

        static let stateTableViewBackgroundColor: UIColor = .systemGray6
    }

    // MARK: Properties

    private(set) var state: Task.State?

    // MARK: Views

    let stateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.stateViewBackgroundColor
        return view
    }()

    let stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: Style.stateTextStyle)
        return label
    }()

    let taskCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: Style.taskCountTextStyle)
        label.textAlignment = .center
        label.backgroundColor = Style.taskCountBackgroundColor
        label.text = Style.taskCountInitialText
        label.textColor = Style.taskCountTextColor
        label.layer.cornerRadius = Style.taskCountCornerRadius
        label.clipsToBounds = true
        return label
    }()

    lazy var stateTableView: StateTableView = {
        let tableView = StateTableView(state: state)
        tableView.backgroundColor = Style.stateTableViewBackgroundColor
        tableView.tableFooterView = UIView()
        return tableView
    }()

    // MARK: Initializers

    init(state: Task.State, pmDelegate: StateTableView.PMDelegate) {
        super.init(frame: .zero)
        self.state = state
        setAttributes()
        setSubviews()
        setLayouts()
        setStateLabelText()
        stateTableView.setDelegates(pmDelegate)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Configures

    func setTaskCountLabel(as value: Int) {
        taskCountLabel.text = "\(value)"
    }

    private func setAttributes() {
        alignment = .fill
        axis = .vertical
        backgroundColor = Style.backgroundColor
        distribution = .fill
        spacing = Style.spacing
    }

    private func setSubviews() {
        stateView.addSubview(stateLabel)
        stateView.addSubview(taskCountLabel)

        addArrangedSubview(stateView)
        addArrangedSubview(stateTableView)
    }

    private func setLayouts() {
        NSLayoutConstraint.activate([
            stateLabel.leadingAnchor.constraint(equalTo: stateView.leadingAnchor, constant: Style.stateInset),
            stateLabel.topAnchor.constraint(equalTo: stateView.topAnchor, constant: Style.stateInset),
            stateLabel.bottomAnchor.constraint(equalTo: stateView.bottomAnchor, constant: -Style.stateInset),
            taskCountLabel.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: Style.stateInset),
            taskCountLabel.widthAnchor.constraint(equalTo: taskCountLabel.heightAnchor),
            taskCountLabel.centerYAnchor.constraint(equalTo: stateLabel.centerYAnchor)
        ])
    }

    private func setStateLabelText() {
        stateLabel.text = state?.rawValue.uppercased()
    }
}
