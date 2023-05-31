//
//  HistoryCell.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import UIKit

final class HistoryCell: UICollectionViewListCell {
    private let titleLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 1
        
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 6
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ history: History) {
        titleLabel.text = history.title
        dateLabel.text = DateFormatter.historyText(history.date)
    }
    
    private func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    private func setupConstraints() {
        let safe = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
            
            separatorLayoutGuide.leadingAnchor.constraint(equalTo: safe.leadingAnchor)
        ])
    }
}
