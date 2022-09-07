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
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let countImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
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
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(countImageView)
        self.addSubview(horizontalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupView() {
        addSubView()
        setupConstraints()
    }
    
    func configure(title: String, count: Int) {
        let numberImageName = "\(count).circle.fill"
        
        titleLabel.text = title
        countImageView.image = UIImage(systemName: numberImageName)
    }
}
