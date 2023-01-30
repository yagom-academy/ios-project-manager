//
//  ListTableViewCell.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = Constraint.stackViewSpacing
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = Constraint.titleLines
        label.text = PlaceHolder.tableViewTitle
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = Constraint.bodyLines
        label.textColor = UIColor.systemGray
        label.text = PlaceHolder.tableViewBody
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = Constraint.dateLines
        label.text = PlaceHolder.tableViewDate
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(bodyLabel)
        mainStackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.stackViewTop),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.stackViewLeading),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constraint.stackViewTrailing),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constraint.stackViewBottom)
        ])
    }
    
    func configureContent(with todo: TodoModel) {
        titleLabel.text = todo.title
        bodyLabel.text = todo.body
        
        let todoDate = todo.date.convertDoubleToDate()
        dateLabel.text = todoDate.customDescription
        
        if todoDate < Date(), todo.status != TodoModel.TodoStatus.done {
            dateLabel.textColor = .red
        } else {
            dateLabel.textColor = .black
        }
    }
    
    private enum Constraint {
        static let stackViewSpacing: CGFloat = 2
        
        static let titleLines = 1
        static let bodyLines = 3
        static let dateLines = 1
        
        static let stackViewTop: CGFloat = 10
        static let stackViewLeading: CGFloat = 5
        static let stackViewTrailing: CGFloat = -5
        static let stackViewBottom: CGFloat = -10
    }
}
