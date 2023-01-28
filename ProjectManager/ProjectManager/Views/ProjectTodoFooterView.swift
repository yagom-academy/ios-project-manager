//
//  ProjectTodoFooterView.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/27.
//

import UIKit

class ProjectTodoFooterView: UIView {
    private let disconnectedNetworkLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("The network connection is disconnected.",
                                       comment: "Disconnected Network Label Text")
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isHidden = true
        return label
    }()
    private let undoButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Undo", comment: "Undo Button Title"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let redoButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Redo", comment: "Redo Button Title"), for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        addSubview(disconnectedNetworkLabel)
        addSubview(undoButton)
        addSubview(redoButton)
        NSLayoutConstraint.activate([
            disconnectedNetworkLabel.topAnchor.constraint(equalTo: topAnchor),
            disconnectedNetworkLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                              constant: Constants.defaultSpacing),
            disconnectedNetworkLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            undoButton.topAnchor.constraint(equalTo: topAnchor),
            undoButton.trailingAnchor.constraint(equalTo: redoButton.leadingAnchor,
                                                 constant: -Constants.defaultSpacing),
            undoButton.bottomAnchor.constraint(equalTo: bottomAnchor),

            redoButton.topAnchor.constraint(equalTo: topAnchor),
            redoButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Constants.defaultSpacing),
            redoButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func addTargetToUndoButton(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        undoButton.addTarget(target, action: action, for: controlEvents)
    }

    func addTargetToRedoButton(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        redoButton.addTarget(target, action: action, for: controlEvents)
    }

    func updateEnableUndoRedoButton(isEnabledUndoButton: Bool, isEnabledRedoButton: Bool) {
        undoButton.isEnabled = isEnabledUndoButton
        redoButton.isEnabled = isEnabledRedoButton
    }

    func showDisconnectedNetworkLabel() {
        disconnectedNetworkLabel.isHidden = false
    }

    func hideDisconnectedNetworkLabel() {
        disconnectedNetworkLabel.isHidden = true
    }
}
