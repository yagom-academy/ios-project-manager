//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/07.
//

import UIKit

final class HeaderView: UIView {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let countImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Methods
    private func addSubView() {
        self.addSubview(titleLabel)
        self.addSubview(countImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            countImageView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 8),
            countImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            countImageView.heightAnchor.constraint(equalTo: self.titleLabel.heightAnchor),
            countImageView.widthAnchor.constraint(equalTo: self.countImageView.heightAnchor)
        ])
    }
    
    private func setupView() {
        addSubView()
        setupConstraints()
        self.backgroundColor = .systemBackground
    }
    
    func configure(title: String, count: Int) {
        let numberImageName = "\(count).circle.fill"
        
        titleLabel.text = title
        countImageView.image = UIImage(systemName: numberImageName)
    }
}
