//
//  ListItemCell.swift
//  ProjectManager
//  Created by inho on 2023/01/12.
//

import UIKit

class ListItemCell: UITableViewCell {
    static let identifier = String(describing: ListItemCell.self)
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        
        return stackView
    }()
    private let listTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        
        return label
    }()
    private let listBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        label.textColor = .systemGray
        label.numberOfLines = 3
        
        return label
    }()
    private let dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        
        return label
    }()
    private let spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        [listTitleLabel, listBodyLabel, dueDateLabel].forEach {
            cellStackView.addArrangedSubview($0)
        }
        contentView.addSubview(spacingView)
        contentView.addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            spacingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spacingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            spacingView.heightAnchor.constraint(equalToConstant: 10),
            
            cellStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 15
            ),
            cellStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -15
            ),
            cellStackView.topAnchor.constraint(equalTo: spacingView.bottomAnchor, constant: 5),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func configureCell(title: String, body: String, dueDate: String) {
        listTitleLabel.text = title
        listBodyLabel.text = body
        dueDateLabel.text = dueDate
    }
}
