//
//  ProjectCell.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

class ProjectCell: UITableViewCell {
    static let identifier = "projectCell"
    
    var titleLabel = UILabel(font: .title3)
    var descriptionLabel = UILabel(font: .body, numberOfLines: 3)
    var dateLabel = UILabel(font: .body, numberOfLines: 0)
    var stack = UIStackView(axis: .vertical,
                            distribution: .fillProportionally,
                            alignment: .leading,
                            spacing: 5)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    func configureLayout() {
        [titleLabel, descriptionLabel, dateLabel].forEach {
            stack.addArrangedSubview($0)
        }
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
