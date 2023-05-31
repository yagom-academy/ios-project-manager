//
//  HistoryCell.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/31.
//

import UIKit

class HistoryCell: UITableViewCell {

    static let identifier = "HistoryCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 8, weight: .light)
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        dateLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabel(title: String, date: Date) {
        titleLabel.text = title
        dateLabel.text = "\(date)"
    }
    
    private func configureUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
}
