//
//  ScheduleHeaderView.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/11.
//

import UIKit

private enum Design {
    static let progressLabelFont = UIFont.preferredFont(forTextStyle: .title1)
    static let progressLabelLeadingAnchorConstant = 10.0
    static let progressLabelTrailingAnchorConstant = 10.0
    static let countButtonColor = UIColor.white
    static let countButtonFont = UIFont.preferredFont(forTextStyle: .callout)
    static let countButtonTintColor = UIColor.black
    static let countButtonBackgroundImage = UIImage(systemName: "circle.fill")
    static let contentViewBackgroundColor = UIColor.systemGray6
}

final class ScheduleListHeaderView: UITableViewHeaderFooterView {

// MARK: - Properties

    let progressLabel: UILabel = {
        let label = UILabel()
        label.font = Design.progressLabelFont
        return label
    }()

    let countButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Design.countButtonColor, for: .normal)
        button.titleLabel?.font = Design.countButtonFont
        button.tintColor = Design.countButtonTintColor
        button.setBackgroundImage(Design.countButtonBackgroundImage, for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()

// MARK: - Initializer

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

// MARK: - Method

    private func commonInit() {
        self.contentView.weakShadow()
        self.contentView.backgroundColor = Design.contentViewBackgroundColor
        self.configureHierachy()
        self.configureConstraint()
    }

    private func configureHierachy() {
        self.contentView.addSubview(self.progressLabel)
        self.contentView.addSubview(self.countButton)

    }

    private func configureConstraint() {
        self.progressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.countButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.progressLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.progressLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: Design.progressLabelLeadingAnchorConstant
            ),
            self.countButton.heightAnchor.constraint(equalTo: self.countButton.widthAnchor),
            self.countButton.centerYAnchor.constraint(equalTo: self.progressLabel.centerYAnchor),
            self.countButton.leadingAnchor.constraint(
                equalTo: self.progressLabel.trailingAnchor,
                constant: Design.progressLabelTrailingAnchorConstant
            )
        ])
    }
}
