//
//  TodoCustomCell.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/12.
//

import UIKit

class TodoCustomCell: UITableViewCell {
    let titleLabel = UILabel(fontStyle: .title3, textColor: .label)
    let bodyLabel = UILabel(fontStyle: .body, numberOfLines: 3, textColor: .systemGray)
    let dateLabel = UILabel(fontStyle: .caption1, textColor: .label)
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
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
        let safeArea = self.safeAreaLayoutGuide
        self.addSubview(stackView)
        [titleLabel, bodyLabel, dateLabel].forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -4)
        ])
    }
}
