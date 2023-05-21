//
//  ListViewCell.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/19.
//

import UIKit

final class ListViewCell: UICollectionViewCell {
    private let listContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .systemGray3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let deadLineLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAddSubviews() {
        self.addSubview(listContentView)
        listContentView.addArrangedSubview(titleLabel)
        listContentView.addArrangedSubview(descriptionLabel)
        listContentView.addArrangedSubview(deadLineLabel)
    }
}
