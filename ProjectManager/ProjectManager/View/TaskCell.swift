//
//  ToDocell.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/03.
//

import UIKit

class TaskCell: UITableViewCell {
    private let cellStackView = UIStackView()
    private let titleLable = UILabel()
    private let discriptionLabel = UILabel()
    private let deadLineLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(
          style: style,
          reuseIdentifier: reuseIdentifier
        )
        setupCellStackView()
        setupCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellStackView() {
        contentView.addSubview(cellStackView)
        cellStackView.addArrangedSubview(titleLable)
        cellStackView.addArrangedSubview(discriptionLabel)
        cellStackView.addArrangedSubview(deadLineLabel)
        cellStackView.axis = .vertical
        
    }
    
    func setupCellConstraints() {
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(with todo: ToDoInfomation) {
        titleLable.text = todo.title
        discriptionLabel.text = todo.discription
        deadLineLabel.text = todo.localizedDateString
    }
}
