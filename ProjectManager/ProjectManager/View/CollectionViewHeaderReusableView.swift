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
        
        return stackView
    }()
    
    private var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private var numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .systemBackground
        label.layer.borderWidth = 1
        label.layer.cornerRadius =  label.layer.frame.size.width / 2
        label.layer.masksToBounds = true
        
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
    
    func configureContent(with data: [ToDoModel]) {

    }
    
    private func configureSubviews() {
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(titlelabel)
        labelStackView.addArrangedSubview(numberLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: topAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
