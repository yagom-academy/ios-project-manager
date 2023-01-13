//
//  TodoCollectionViewCell.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    static let identifier = "TodoTableViewCell"
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.textColor = UIColor.systemGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 1
        label.textColor = UIColor.black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        bodyLabel.text = ""
        dateLabel.text = ""
    }
    
    private func configureLayout() {
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(bodyLabel)
        mainStackView.addArrangedSubview(dateLabel)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            titleLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }
    
    func configureContent(with todoModel: TodoModel) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = todoModel.title
            self?.bodyLabel.text = todoModel.body
            self?.dateLabel.text = "\(Date())"
        }
    }
}
