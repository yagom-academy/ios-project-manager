//
//  PlanListHeaderView.swift
//  ProjectManager
//
//  Created by som on 2023/01/18.
//

import UIKit

final class PlanListHeaderView: UITableViewHeaderFooterView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.cornerRadius = min(label.bounds.size.width, label.bounds.size.height) / 3
        label.clipsToBounds = true
        label.backgroundColor = .black
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .white
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        contentView.backgroundColor = .systemGray6

        addSubview(titleLabel)
        addSubview(countLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])
    }

    func configure(title: String, count: Int) {
        titleLabel.text = title
        countLabel.text = "\(count)"
    }
}

extension PlanListHeaderView: CellReusable { }
