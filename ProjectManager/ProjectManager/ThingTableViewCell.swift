//
//  ThingTableViewCell.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/08.
//

import UIKit

class ThingTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    private let titleLabel = UILabel()
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    private let dateLabel = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
        dateLabel.text = nil
        dateLabel.textColor = UIColor.label
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureLayouts() {
        let stackView = UIStackView()
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setContents(_ thing: Thing, _ isDone: Bool) {
        titleLabel.text = thing.title
        bodyLabel.text = thing.body
        dateLabel.text = thing.dateString
        if isDone == false {
            changeDateTextColorByDate(thing.date)
        }
    }
    
    private func changeDateTextColorByDate(_ date: Int) {
        let currentDate = Int(Date().timeIntervalSince1970)
        if date <= currentDate {
            dateLabel.textColor = .systemRed
        }
    }
}
