//
//  CustomTableViewHeader.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/21.
//

import UIKit

class CustomTableViewHeader: UITableViewHeaderFooterView {
    static let identifier = "headerCell"
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.backgroundColor = .systemGray6
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        label.layer.cornerRadius = 16
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(state: State, data: [ProjectModel]) {
        titleLabel.text = state.title
        countLabel.text = data.filter({ $0.state == state }).count.description
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
