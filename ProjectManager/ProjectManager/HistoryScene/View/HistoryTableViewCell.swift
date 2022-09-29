//
//  HistoryTableViewCell.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/23.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    private let cellStackView = DefaultStackViewBuilder()
        .useAutoLayout()
        .setAxis(.vertical)
        .setAlignment(.leading)
        .setDistribution(.fillEqually)
        .useLayoutMargin()
        .setLayoutMargin(top: 20,
                         left: 20,
                         bottom: 20,
                         right: 20)
        .stackView
    
    private let titleLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.title3)
        .numberOfLines(0)
        .label
    
    private let dateLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.body)
        .setTextColor(with: .systemGray3)
        .label
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialView() {
        backgroundColor = .systemBackground
        addSubview(cellStackView)
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellStackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        cellStackView.addArrangedSubview(titleLabel)
        cellStackView.addArrangedSubview(dateLabel)
    }
    
    func setupData(with model: History) {
        titleLabel.text = model.title
        dateLabel.text = model.date.timeIntervalSince1970.translateToTime()
    }
}
