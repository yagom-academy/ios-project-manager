//
//  ProjectTaskCell.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/14.
//

import UIKit

class ProjectTaskCell: UITableViewCell {
        
    //MARK: - UI Properties
    
    private let taskInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .gray
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let deadLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    //MARK: Table View Cell Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUIComponents()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.deadLineLabel.textColor = .black
    }
    
    //MARK: - Setup Cell
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            taskInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            taskInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            taskInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func addUIComponents() {
        contentView.addSubview(taskInfoStackView)
        
        taskInfoStackView.addArrangedSubview(titleLabel)
        taskInfoStackView.addArrangedSubview(descriptionLabel)
        taskInfoStackView.addArrangedSubview(deadLineLabel)
    }
    
    func setupData(_ data: ProjectTask) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        deadLineLabel.text = data.date.description
    }
    
    func configureDeadLineLabel(date: Date) {
        if Date() >= date {
            deadLineLabel.textColor = .red
        }
    }
}
