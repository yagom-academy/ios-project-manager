//
//  MainLeftTableViewCell.swift
//  ProjectManager
//
//  Created by Dragon 2023/01/13.
//

import UIKit

class MainLeftTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "MainLeftTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 3
        return label
    }()
    let dateLabel: UILabel = {
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
    
    // MARK: SetSelected
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Internal Methods
    
    func configureLabel(todoData: ProjectData) {
        titleLabel.text = todoData.title
        bodyLabel.text = todoData.body
        dateLabel.text = convertDateForm(todoDate: todoData.deadline)
        
        checkDate(deadline: todoData.deadline)
    }

    // MARK: Private Methods
    
    private func checkDate(deadline: Double) {
        if Date().timeIntervalSince1970 > deadline {
            dateLabel.textColor = .systemRed
        }
    }
    
    private func convertDateForm(todoDate: Double) -> String {
        let date = Date(timeIntervalSince1970: todoDate)
        let formatter: DateFormatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.setLocalizedDateFormatFromTemplate("yyyy.MM.dd")
        
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
