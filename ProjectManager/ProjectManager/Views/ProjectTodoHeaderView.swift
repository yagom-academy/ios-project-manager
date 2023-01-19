//
//  ProjectTodoHeaderView.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import UIKit

final class ProjectTodoHeaderView: UIView {
    let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    let itemCountLabel = ItemCountLabel()

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = ProjectColor.collectionViewBackground.color
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(itemCountLabel)
        let spacing = Constants.defaultSpacing
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
            itemCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            itemCountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: spacing),
            itemCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
            itemCountLabel.widthAnchor.constraint(equalTo: itemCountLabel.heightAnchor)
        ])
    }
}
