//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 김태형 on 2021/03/30.
//
import UIKit

final class TableViewCell: UITableViewCell {
    // MARK: - Property
    
    static var identifier: String {
        return "\(self)"
    }
    
    // MARK: - Outlet
    
    private let titleLabel: UILabel = {
        let label = makeLabel(textStyle: .title1)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = makeLabel()
        label.textColor = UIColor.systemGray
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = makeLabel()
        return label
    }()
    
    private let emptyView = UIView()
    
    static private func makeLabel(textStyle: UIFont.TextStyle = .body, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: textStyle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func configure(_ todo: Todo) {
        titleLabel.text = todo.title
        titleLabel.numberOfLines = 1
        descriptionLabel.numberOfLines = 3
        descriptionLabel.text = todo.description
        deadlineLabel.text = "\(todo.convertedDate)"
    }
    
    func determineColor(_ deadline: Double) {
        let currentDate = Date().timeIntervalSince1970
        if deadline < currentDate {
            deadlineLabel.textColor = .systemRed
        }
    }
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        deadlineLabel.text = nil
        deadlineLabel.textColor = .black
    }
    
    private func configureConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(deadlineLabel)
        contentView.addSubview(emptyView)
        emptyView.backgroundColor = .systemGroupedBackground
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyView.heightAnchor.constraint(equalToConstant: 10),
            emptyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: deadlineLabel.topAnchor, constant: -10),
            
            deadlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            deadlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            deadlineLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
        ])
    }
}
