//
//  HistoryCell.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import UIKit

final class HistoryCell: UITableViewCell {
    private let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let actionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpCell()
        self.setUpHistoryStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell() {
        self.backgroundColor = .systemGray5
        self.contentView.backgroundColor = .systemBackground
    }
    
    private func setUpHistoryStackView() {
        self.contentView.addSubview(self.historyStackView)
        self.contentView.addSubview(self.dateLabel)
        self.historyStackView.addArrangedSubviews(with: [self.actionLabel, self.titleLabel, self.statusLabel])
        
        NSLayoutConstraint.activate([
            self.historyStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.historyStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.historyStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.historyStackView.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func configure(_ history: History) {
        self.actionLabel.text = history.action.description
        self.titleLabel.text = history.title
        self.statusLabel.text = history.status.value
        self.dateLabel.text = history.date.convertToString()
    }
}
