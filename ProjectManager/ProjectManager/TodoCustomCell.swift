//
//  TodoCustomCell.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/12.
//

import UIKit

class TodoCustomCell: UITableViewCell {
    let titleLabel = UILabel(fontStyle: .title3, textColor: .label)
    let bodyLabel = UILabel(fontStyle: .body, numberOfLines: 3, textColor: .systemGray3)
    let dateLabel = UILabel(fontStyle: .caption1, textColor: .label)
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .firstBaseline
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraintLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func constraintLayout() {
        self.addSubview(stackView)
        [titleLabel, bodyLabel, dateLabel].forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
