//
//  ListStackView.swift
//  ProjectManager
//  Created by inho on 2023/01/12.
//

import UIKit

class ListStackView: UIStackView {
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constant.spacing
        stackView.alignment = .center
        
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TODO"
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    private let listCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.backgroundColor = .black
        label.textColor = .white
        label.layer.cornerRadius = label.frame.width / 2
        label.layer.masksToBounds = true
        
        return label
    }()
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListItemCell.self, forCellReuseIdentifier: ListItemCell.identifier)
        
        return tableView
    }()

    convenience init(title: String) {
        self.init(frame: .zero)

        titleLabel.text = title
        configureLayout()
    }
    
    private func configureStackView() {
        backgroundColor = .systemGray6
        axis = .vertical
        spacing = Constant.spacing
    }
    
    private func configureLayout() {
        [titleLabel, listCountLabel].forEach(titleStackView.addArrangedSubview(_:))
        [titleStackView, listTableView].forEach(addArrangedSubview(_:))
    }
}

private enum Constant {
    static let spacing: CGFloat = 10
}
