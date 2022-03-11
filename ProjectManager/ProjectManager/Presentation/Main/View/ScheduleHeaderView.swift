//
//  ScheduleHeaderView.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/11.
//

import UIKit

class ScheduleHeaderView: UITableViewHeaderFooterView {

// MARK: - Properties

    let progressLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

    let countButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .callout)
        button.tintColor = .black
        button.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
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
        self.contentView.backgroundColor = .systemGray6
        self.configureHierachy()
        self.configureConstraint()
    }

    private func configureHierachy() {
        self.contentView.addSubview(self.progressLabel)
        self.contentView.addSubview(self.countButton)

    }

    private func configureConstraint() {
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        countButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.progressLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.progressLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: 10),
            self.countButton.heightAnchor.constraint(equalTo: self.countButton.widthAnchor),
            self.countButton.centerYAnchor.constraint(equalTo: self.progressLabel.centerYAnchor),
            self.countButton.leadingAnchor.constraint(
                equalTo: self.progressLabel.trailingAnchor,
                constant: 10)
        ])
    }
}
