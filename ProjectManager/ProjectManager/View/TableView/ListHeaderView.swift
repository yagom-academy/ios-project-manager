//
//  ListHeaderView.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/13.
//

import UIKit

final class ListHeaderView: UITableViewHeaderFooterView {
    var status: HeaderStatus?
    
    enum HeaderStatus {
        case todo
        case doing
        case done
        
        var title: String {
            switch self {
            case .todo:
                return "TODO"
            case .doing:
                return "DOING"
            case .done:
                return "DONE"
            }
        }
    }
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle,
                                          compatibleWith: .none)
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = Constraint.countCornerRadius
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor.black.cgColor
        label.textColor = .white
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        contentView.backgroundColor = UIColor.systemGray6
        addSubview(statusLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.statusTop),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.statusLeading),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constraint.statusBottom),
            
            countLabel.heightAnchor.constraint(equalToConstant: Constraint.countHeight),
            countLabel.widthAnchor.constraint(equalToConstant: Constraint.countWidth),
            countLabel.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: Constraint.countLeading),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constraint.countTrailing)
        ])
    }
    
    func configureView(status: HeaderStatus, count: Int) {
        self.status = status
        statusLabel.text = self.status?.title
        updateCountLabel(count)
    }
    
    func updateCountLabel(_ count: Int) {
        countLabel.text = count.description
    }
    
    private enum Constraint {
        static let statusTop: CGFloat = 0
        static let statusLeading: CGFloat = 10
        static let statusBottom: CGFloat = -5
        
        static let countHeight: CGFloat = countWidth
        static let countWidth: CGFloat = 35
        static let countCornerRadius: CGFloat = countWidth / 2
        static let countLeading: CGFloat = 5
        static let countTrailing: CGFloat = -5
    }
}
