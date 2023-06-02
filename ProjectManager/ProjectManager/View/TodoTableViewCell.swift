//
//  ToDoTableViewCell.swift
//  ProjectManager
//
//  Created by goat on 2023/05/17.
//

import UIKit

final class ToDoTableViewCell: UITableViewCell, IdentifierProtocol {
    
    func setUpIdentifier() -> String {
        let identifier = String(describing: type(of: self))
        return identifier
    }
    
    lazy var identifier = setUpIdentifier()
    
    private var toDoList: ToDoList?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .lightGray
        label.numberOfLines = 3
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    
    private func configureCellUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
    }
    
    func setUpLabel(toDoList: ToDoList) {
        self.toDoList = toDoList
    
        titleLabel.text = toDoList.title
        descriptionLabel.text = toDoList.description
        
        let formattedDate = DateFormatterManager.shared.convertDateToString(date: toDoList.date)
        
        if toDoList.date > Date() {
            dateLabel.text = formattedDate
        } else {
            dateLabel.text = formattedDate
            dateLabel.textColor = .red
        }
    }
}
