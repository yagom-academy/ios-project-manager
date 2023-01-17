//
//  ListHeaderReusableView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

final class ListHeaderReusableView: UICollectionReusableView {

    typealias Text = Constant.Text
    typealias Style = Constant.Style
    typealias Number = Constant.Number

    override var reuseIdentifier: String?  {
        return "ListHeaderReusableView"
    }

    private let titleView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Style.stackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: Style.listTitleMargin,
                                               left: Style.listTitleMargin,
                                               bottom: Style.listTitleMargin,
                                               right: Style.listTitleMargin)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    private let titleLabel: UILabel = UILabel()
    private lazy var countLabel: CircleLabel = CircleLabel(frame: .zero)

    init(title: String, count: Int, frame: CGRect) {
        super.init(frame: frame)

        configureLabel(title: title, count: count)
        configureViewHierarchy()
        configureLayoutConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLabel(title: String, count: Int) {
        titleLabel.text = title
        if count > Number.maxCount {
            countLabel.text = Text.overCount
        } else {
            countLabel.text = String(count)
        }
    }

    private func configureViewHierarchy() {
        titleView.addArrangedSubview(titleLabel)
        titleView.addArrangedSubview(countLabel)
        addSubview(titleView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
