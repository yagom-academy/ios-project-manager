//
//  TaskTableViewCell.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit
import SnapKit

final class TaskTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var baseCellStackView = UIStackView(
        arrangedSubviews: [
            titleLabel,
            descriptionLabel,
            dateLabel
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .preferredFont(for: .title2, weight: .bold)
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .preferredFont(for: .title3, weight: .bold)
        $0.numberOfLines = 3
        $0.textColor = .gray
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.font = .preferredFont(for: .headline, weight: .bold)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUILayout() {
        contentView.addSubview(baseCellStackView)
        baseCellStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func setupContents(data: Task) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        dateLabel.text = data.date
    }
}
