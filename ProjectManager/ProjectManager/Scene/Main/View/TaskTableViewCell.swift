//
//  TaskTableViewCell.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit
import SnapKit

final class TaskTableViewCell: UITableViewCell {
    
    fileprivate enum Constants {
        static let numberOfLines = 3
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    private(set) var task: Task?
    
    private let baseCellStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .preferredFont(for: .title2, weight: .medium)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = .preferredFont(for: .title3, weight: .medium)
        $0.numberOfLines = Constants.numberOfLines
        $0.textColor = .gray
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .preferredFont(for: .headline, weight: .medium)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        contentView.addSubview(baseCellStackView)
        
        baseCellStackView.addArrangedSubview(titleLabel)
        baseCellStackView.addArrangedSubview(descriptionLabel)
        baseCellStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupUILayout() {
        baseCellStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func setupContents(task: Task) {
        self.task = task
        
        titleLabel.text = task.title
        descriptionLabel.text = task.body
        dateLabel.text = formattedString(date: task.date)
        guard task.taskType != .done else {
            return
        }
        
        let now = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        if now > task.date {
            dateLabel.textColor = .systemRed
        } else {
            dateLabel.textColor = .black
        }
    }
    
    private func formattedString(date: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        dateFormatter.locale = Locale(
            identifier:
                Locale.current.identifier
        )
        return dateFormatter.string(from: Date(timeIntervalSince1970: date))
    }
}
