//
//  TaskCell.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    // MARK: UIComponents - StackView
    
    private lazy var baseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: UIComponents - UILabel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    func setUpLabel(task: Task) {
        self.titleLabel.text = task.title
        self.bodyLabel.text = task.body
        self.dateLabel.text = task.date.formattedString
        setDateLabelColor(date: task.date)
    }
    
    func setDateLabelColor(date: Date) {
        let result = date.compare(Date())
        switch result {
        case .orderedAscending:
            dateLabel.textColor = .red
        default:
            dateLabel.textColor = .black
        }
    }
}
