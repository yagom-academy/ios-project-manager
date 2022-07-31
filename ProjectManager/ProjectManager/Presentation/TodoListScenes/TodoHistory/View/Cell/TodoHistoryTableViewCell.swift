//
//  TodoHistoryTableViewCell.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/19.
//

import UIKit

final class TodoHistoryTableViewCell: UITableViewCell {
    private let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "yyyy. M. d. HH:MM:SS a"
        return formatter
    }()
    
    private let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let createAtLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        addSubviews()
        setupConstraint()
    }
    
    private func addSubviews() {
        contentView.addSubview(historyStackView)
        historyStackView.addArrangeSubviews(titleLabel, createAtLabel)
    }
    
    private func setupConstraint() {
        historyStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    func setupData(with item: TodoHistory) {
        self.titleLabel.text = item.title
        self.createAtLabel.text = dateformatter.string(from: item.createdAt)
    }
}
