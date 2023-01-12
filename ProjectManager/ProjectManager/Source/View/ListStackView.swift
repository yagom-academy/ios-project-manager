//
//  ListStackView.swift
//  ProjectManager
//  Created by inho on 2023/01/12.
//

import UIKit

class ListStackView: UIStackView {
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TODO"
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    let listCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.backgroundColor = .black
        label.textColor = .white
        label.layer.cornerRadius = label.frame.width / 2
        label.layer.masksToBounds = true
        
        return label
    }()
    let listTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()

    convenience init(title: String) {
        self.init(frame: .zero)

        titleLabel.text = title
        configureLayout()
    }
    
    func configureStackView() {
        backgroundColor = .systemGray6
        axis = .vertical
        spacing = 10
    }
    
    func configureLayout() {
        [titleLabel, listCountLabel].forEach(titleStackView.addArrangedSubview(_:))
        [titleStackView, listTableView].forEach(addArrangedSubview(_:))
    }
}
