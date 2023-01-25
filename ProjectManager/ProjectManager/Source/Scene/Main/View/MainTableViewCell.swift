//
//  MainLeftTableViewCell.swift
//  ProjectManager
//
//  Created by Dragon 2023/01/13.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    // MARK: Identifier
    
    static let leftIdentifier = "MainLeftTableViewCell"
    static let centerIdentifier = "MainCenterTableViewCell"
    static let rightIdentifier = "MainRightTableViewCell"
    
    // MARK: Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }()
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 3
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpStackView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal Methods
    
    func configureLabel(data: ProjectData) {
        titleLabel.text = data.title
        bodyLabel.text = data.body
        dateLabel.text = convertDateForm(todoDate: data.deadline)
        
        checkDate(deadline: data.deadline)
    }

    // MARK: Private Methods
    
    private func checkDate(deadline: Double) {
        if Date().timeIntervalSince1970 > deadline + NameSpace.dayToSecond {
            dateLabel.textColor = .systemRed
        }
    }
    
    private func convertDateForm(todoDate: Double) -> String {
        let date = Date(timeIntervalSince1970: todoDate)
        let formatter: DateFormatter = DateFormatter()
        
        formatter.locale = Locale(identifier: MainNameSpace.defaultDateLabelLocale)
        formatter.setLocalizedDateFormatFromTemplate(MainNameSpace.defaultDateLabelFormat)
        
        return formatter.string(from: date)
    }
    
    private func setUpStackView() {
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(bodyLabel)
        totalStackView.addArrangedSubview(dateLabel)
    }
    
    private func configureLayout() {
        contentView.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            totalStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),
            totalStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),
            totalStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10
            )
        ])
    }
}

// MARK: - NameSpace

private enum NameSpace {
    static let dayToSecond = 86400.0
}
