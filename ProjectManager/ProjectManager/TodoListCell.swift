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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .red
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }
    
    func configure(text: String) {
        titleLabel.text = text
    }
    
}
