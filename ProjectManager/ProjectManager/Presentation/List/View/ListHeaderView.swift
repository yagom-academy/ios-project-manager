//
//  ListHeaderView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

final class ListHeaderView: UIView {

    typealias Text = Constant.Text
    typealias Style = Constant.Style
    typealias Color = Constant.Color
    typealias Number = Constant.Number

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
    private let countLabel: CircleLabel = CircleLabel(frame: .zero)
    
    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setTitle(text: title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureViewHierarchy()
        configureLayoutConstraint()
    }
    
    private func setTitle(text: String) {
        titleLabel.text = text
    }
    
    func setCount(number: Int?) {
        guard let count = number else {
            return
        }
        if count > Number.maxCount {
            countLabel.text = Text.overCount
        } else {
            countLabel.text = String(count)
        }
    }

    private func configureViewHierarchy() {
        [titleLabel, countLabel].forEach {
            titleView.addArrangedSubview($0)
        }
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
