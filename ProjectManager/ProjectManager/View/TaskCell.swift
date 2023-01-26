//
//  TaskCell.swift
//  ProjectManager
//
//  Created by jin on 1/21/23.
//

import UIKit

class TaskCell: UITableViewCell {

    var task: Task? {
        didSet {
            configureData()
        }
    }

    enum Constant {
        static let spacing = 10.0
        static let nagativeSpacing = -10.0
    }

    static let cellIdentifier = String.init(describing: TaskCell.self)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLongPressGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureData() {
        titleLabel.text = self.task?.title
        descriptionLabel.text = self.task?.description
        dateLabel.textColor = checkIfDatePassedNow(date: self.task?.date ?? Date()) ? .red : .black
        dateLabel.text = self.task?.date.description
    }

    func configureUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.spacing),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constant.nagativeSpacing),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.spacing)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constant.spacing),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constant.nagativeSpacing)
        ])
    }

    func checkIfDatePassedNow(date: Date) -> Bool {
        return Date() > date
    }
}

extension TaskCell {
    private func configureLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(notifyLongPressed))
        longPressGesture.delaysTouchesBegan = true
        
        self.contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func notifyLongPressed() {
        print("long pressed")
    }
}
