//
//  CollectionViewHeaderReusableView.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/21.
//

import UIKit

class CollectionViewHeaderReusableView: UICollectionReusableView {
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.backgroundColor = .systemGray6
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .systemBackground
        label.layer.borderWidth = 5
        label.layer.cornerRadius = 17
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(title: String, count: Int) {
        titleLabel.text = title
        countLabel.text = count.description
    }
    
    private func configureSubviews() {
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(countLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: topAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            countLabel.widthAnchor.constraint(equalTo: titleLabel.heightAnchor),
            countLabel.heightAnchor.constraint(equalTo: countLabel.widthAnchor)
        ])
    }
}
