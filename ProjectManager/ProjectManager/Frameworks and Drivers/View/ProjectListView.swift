//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/15.
//

import UIKit

final class ProjectListView: UIView, PlanListView {

    typealias Text = ProjectConstant.Text
    typealias Style = ProjectConstant.Style
    typealias Color = ProjectConstant.Color
    typealias Number = ProjectConstant.Number
    
    var delegate: PlanListViewDelegate?
    var state: PlanState
    private let titleView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Style.stackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.setContentHuggingPriority(.required, for: .vertical)
        stackView.layoutMargins = UIEdgeInsets(top: Style.listTitleMargin,
                                               left: Style.listTitleMargin,
                                               bottom: Style.listTitleMargin,
                                               right: Style.listTitleMargin)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        switch state {
        case .toDo:
            label.text = Text.toDoTitle
        case .doing:
            label.text = Text.doingTitle
        case .done:
            label.text = Text.doneTitle
        }

        return label
    }()
    private lazy var countLabel: CircleLabel = {
        let label = CircleLabel(frame: .zero)
        let count = list?.count ?? .zero
        if count > Number.maxCount {
            label.text = Text.overCount
        } else {
            label.text = String(count)
        }

        return label
    }()
    private lazy var listView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.delegate = self.delegate

        return collectionView
    }()

    init(state: PlanState, frame: CGRect) {
        self.state = state
        super.init(frame: frame)
        configureUIComponent()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUIComponent() {
        backgroundColor = Color.PlanListBackground
        configureViewHierarchy()
        configureLayoutConstraint()
    }

    private func configureViewHierarchy() {
        titleView.addArrangedSubview(titleLabel)
        titleView.addArrangedSubview(countLabel)
        addSubview(titleView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
