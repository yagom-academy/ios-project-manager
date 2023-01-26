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
    
    private let listCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = HeaderViewValue.circleCornerRadius
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
        addSubview(listCountLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: listCountLabel.leadingAnchor, constant: -5),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            listCountLabel.heightAnchor.constraint(equalToConstant: HeaderViewValue.countLabelWidth),
            listCountLabel.widthAnchor.constraint(equalTo: listCountLabel.heightAnchor),
            listCountLabel.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            listCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configureView(status: HeaderStatus, count: Int) {
        self.status = status
        statusLabel.text = self.status?.title
        updateCountLabel(count)
    }
    
    func updateCountLabel(_ count: Int) {
        listCountLabel.text = count.description
    }
}
