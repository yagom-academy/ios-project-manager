//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import UIKit

final class TodoListCell: UITableViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpCell()
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setUpCell() {
        self.addSubview(titleLabel)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configure(_ todo: Todo) {
        self.titleLabel.text = todo.title
    }
}
