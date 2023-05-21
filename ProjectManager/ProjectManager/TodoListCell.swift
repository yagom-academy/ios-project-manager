//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by Andrew on 2023/05/19.
//

import UIKit

class TodoListCell: UICollectionViewListCell {
    private let titleLabel = {
        let label = UILabel()
        return label
    }()
    
    private let contentLabel = {
        let label = UILabel()
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        return label
    }()
    
    private let cellStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(cellStackView)
        cellStackView.addArrangedSubview(titleLabel)
        cellStackView.addArrangedSubview(contentLabel)
        cellStackView.addArrangedSubview(dateLabel)
        
        cellStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
    }
    
    func configure(title: String, content: String, date: Date) {
        titleLabel.text = title
        contentLabel.text = content
        dateLabel.text = Date.dateString()
    }
    
}
