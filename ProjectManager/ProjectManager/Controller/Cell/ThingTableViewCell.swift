//
//  ThingTableViewCell.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import UIKit

final class ThingTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - Property
    
    var isDone: Bool = false
    
    // MARK: - Outlet
    
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureConstraints()
        configureLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
        dateLabel.textColor = .label
    }
    
    // MARK: - UI

    private func configureLabel() {
        titleLabel.configure(textSize: .title3)
        descriptionLabel.configure(textColor: .gray, numberOfLines: 3)
        dateLabel.configure(textSize: .caption1)
    }
    
    private func configureConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell(_ thing: Thing) {
        titleLabel.text = thing.title
        descriptionLabel.text = thing.description
        dateLabel.text = thing.dateString
        changeDateColor(date: thing.date)
    }
    
    private func changeDateColor(date: Date) {
        if isDone == false, date < Date() {
            dateLabel.textColor = .red
        } else {
            dateLabel.textColor = .label
        }
    }
}
