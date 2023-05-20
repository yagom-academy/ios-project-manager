//
//  HeaderReusableView.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

import UIKit

final class HeaderReusableView: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let countImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        drawBottomBorder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, count: String) {
        titleLabel.text = title
        countImageView.image = UIImage(systemName: "\(count).circle.fill")
    }
    
    private func configureLayout() {
        self.addSubview(titleLabel)
        self.addSubview(countImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            countImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            countImageView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            countImageView.widthAnchor.constraint(equalTo: countImageView.heightAnchor),
        ])
    }
    
    private func drawBottomBorder() {
        layer.drawBorder(color: .systemGray4, width: 1.0)
    }
}
