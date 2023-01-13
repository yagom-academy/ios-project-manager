//
//  TodoHeaderView.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/13.
//

import UIKit

final class TodoHeaderView: UITableViewHeaderFooterView {
    static let identifier = "TodoHeaderView"
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle,
                                          compatibleWith: .none)
        
        return label
    }()
    
    private let listNumberImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.black
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        self.contentView.backgroundColor = UIColor.systemGray6
        self.addSubview(statusLabel)
        self.addSubview(listNumberImage)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: listNumberImage.leadingAnchor, constant: -5),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            listNumberImage.heightAnchor.constraint(equalToConstant: 35),
            listNumberImage.widthAnchor.constraint(equalTo: listNumberImage.heightAnchor),
            listNumberImage.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            listNumberImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configureContent(of todoStatus: TodoModel.TodoStatus) {
        switch todoStatus {
        case .todo:
            statusLabel.text = "TODO"
        case .doing:
            statusLabel.text = "DOING"
        case .done:
            statusLabel.text = "DONE"
        }
    }
    
    func updateCount(_ count: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.listNumberImage.image = UIImage(systemName: "\(count).circle.fill")
        }
    }
}
