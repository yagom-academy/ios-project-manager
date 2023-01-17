//
//  ProjectTableViewHeaderView.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/14.
//

import UIKit

class ProjectTableViewHeaderView: UITableViewHeaderFooterView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureView()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        addSubview(titleLabel)
        addSubview(countLabel)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countLabel.topAnchor.constraint(equalTo: topAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])
    }

    func configure(title: String, count: Int) {
        titleLabel.text = title
        countLabel.text = "\(count)"
    }
}

// MARK: Reusable 프로토콜 채택
extension ProjectTableViewHeaderView: Reusable { }
