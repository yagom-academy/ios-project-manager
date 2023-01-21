//
//  CustomHeaderView.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/13.
//

import UIKit

final class CustomHeaderView: UITableViewHeaderFooterView {
    let titleLabel: UILabel = {
        let label = UILabel(fontStyle: .title1, textColor: .label)
        label.layer.cornerRadius = 0.5
        
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel(fontStyle: .title2, textColor: .systemBackground)
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.label.cgColor
        label.layer.backgroundColor = UIColor.label.cgColor
        
        return label
    }()
    
    private let stackView = UIStackView(
        axis: .horizontal,
        alignment: .center,
        distribution: .equalSpacing,
        spacing: 8
    )
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        countLabel.layer.cornerRadius = countLabel.bounds.size.height * 0.5
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(stackView)
        [titleLabel, countLabel].forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])
    }
}
