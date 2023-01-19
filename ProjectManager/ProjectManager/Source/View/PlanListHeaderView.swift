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
        let label = UILabel(frame: CGRect(x: .zero,
                                          y: .zero,
                                          width: LayoutConstraint.size,
                                          height: LayoutConstraint.size))
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
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstraint.leadingConstant),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstraint.topConstant),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutConstraint.leadingConstant),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: LayoutConstraint.bottomConstant),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])
    }

    func configure(title: String, count: Int) {
        titleLabel.text = title
        countLabel.text = "\(count)"
    }

    private enum LayoutConstraint {
        static let size: CGFloat = 50
        static let radius: Int = 3
        static let topConstant: CGFloat = 8
        static let leadingConstant: CGFloat = 8
        static let bottomConstant: CGFloat = -8
    }
}

extension PlanListHeaderView: CellReusable { }
