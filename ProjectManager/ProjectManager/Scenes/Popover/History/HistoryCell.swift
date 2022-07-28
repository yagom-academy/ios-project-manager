//
//  HistoryCell.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/25.
//

import UIKit

final class HistoryCell: UITableViewCell {
    
    // MARK: UIComponents - StackView
    
    private lazy var baseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    // MARK: UIComponents - UILabel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray6
        return label
    }()
    
    // MARK: initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(baseStackView)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Cell life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        dateLabel.text = ""
    }
    
    // MARK: functions
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            baseStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            baseStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            baseStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setUpLabel(history: History) {
        self.titleLabel.text = makeTitle(history: history)
        self.dateLabel.text = history.date.isoDateString
    }
    
    func makeTitle(history: History) -> String {
        var prefixString: String = ""
        var suffixString: String = ""
        
        switch history.changedType {
        case .move:
            prefixString = "Moved"
            suffixString = "from \(history.from.rawValue) to \(history.to?.rawValue ?? "")"
        case .add:
            prefixString = "Added"
        case .delete:
            prefixString = "Removed"
            suffixString = "from \(history.from)"
        case .update:
            prefixString = "Updated"
        }
        return prefixString + history.title + suffixString
    }
}
