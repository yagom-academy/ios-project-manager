//
//  ProjectManager - HeaderCell.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class HeaderCell: UICollectionViewCell {
    let identifier = "HeaderCell"
    
    let contentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 20
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureContentStackView()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(status: Status, number: Int) {
        switch status {
        case .todo:
            statusLabel.text = "TODO"
        case .doing:
            statusLabel.text = "DOING"
        case .done:
            statusLabel.text = "DONE"
        }
        numberLabel.text = "\(number)"
    }
    
    private func configureUI() {
        contentView.backgroundColor = .systemGray6
    }
    
    private func configureContentStackView() {
        self.addSubview(contentStackView)
        contentStackView.addArrangedSubview(statusLabel)
        contentStackView.addArrangedSubview(numberLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
