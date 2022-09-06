//
//  ToDoListCollectionViewCell.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/06.
//

import UIKit

final class ToDoListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .magenta
        
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.backgroundColor = .blue
        label.text = "titleLabel"
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.backgroundColor = .green
        label.textColor = .lightGray
        label.text = "descriptionLabel"
        
        return label
    }()
    
    let timeLimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .yellow
        label.text = "timeLimitLabel"
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupVerticalStackViewLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupVerticalStackViewLayout()
    }
    
    
    // MARK: - Functions
    
    private func setupSubviews() {
        self.addSubview(verticalStackView)
        
        [titleLabel, descriptionLabel, timeLimitLabel]
            .forEach { verticalStackView.addArrangedSubview($0) }
    }
    
    private func setupVerticalStackViewLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
