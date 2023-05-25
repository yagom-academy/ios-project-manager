//
//  CollectionViewHeader.swift
//  ProjectManager
//
//  Created by Andrew on 2023/05/25.
//

import UIKit

class Header: UICollectionReusableView {
    
    let headerLabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let cellCountLabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.clipsToBounds = true
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        return label
    }()
    
    private let headerStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
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
        addSubview(headerStackView)
        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(cellCountLabel)
        
        cellCountLabel.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
        headerStackView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.bottom.equalTo(-10)
        }
        
    }
    
}
