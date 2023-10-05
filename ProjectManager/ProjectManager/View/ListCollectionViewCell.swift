//
//  ListCollectionViewCell.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/03.
//

import UIKit

final class ListCollectionViewCell: UICollectionViewListCell {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy. MM. dd."
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 3
        label.textColor = .lightGray
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContents(title: String, description: String, deadline: Double) {
        titleLabel.text = title
        descriptionLabel.text = description
        deadlineLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: deadline))
        deadlineLabel.textColor = isPassDeadline(deadline: deadline) ? .red : .black
    }
    
    private func isPassDeadline(deadline: Double) -> Bool {
        let currentDateString = dateFormatter.string(from: Date())
        let deadlineDateString = dateFormatter.string(from: Date(timeIntervalSince1970: deadline))
        let currentDate = dateFormatter.date(from: currentDateString) ?? Date()
        let deadlineDate = dateFormatter.date(from: deadlineDateString) ?? Date()
        
        return currentDate.timeIntervalSince1970 > deadlineDate.timeIntervalSince1970
    }
    
    private func configureUI() {
        [titleLabel, descriptionLabel, deadlineLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        descriptionLabel.setContentHuggingPriority(.init(1), for: .vertical)
    }
}
