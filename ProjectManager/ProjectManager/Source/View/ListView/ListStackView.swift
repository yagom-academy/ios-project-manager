//
//  ListStackView.swift
//  ProjectManager
//  Created by inho on 2023/01/12.
//

import UIKit

class ListStackView: UIStackView {
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Constant.spacing
        stackView.alignment = .center
        
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    private let listCountLabel: EllipseLabel = {
        let label = EllipseLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        
        return label
    }()
    let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListItemCell.self, forCellReuseIdentifier: ListItemCell.identifier)
        tableView.separatorInset = .zero
        
        return tableView
    }()

    convenience init(title: String) {
        self.init(frame: .zero)

        titleLabel.text = title
        configureStackView()
        configureLayout()
    }
    
    private func configureStackView() {
        backgroundColor = .systemGray6
        axis = .vertical
        spacing = Constant.spacing
    }
    
    private func configureLayout() {
        [titleLabel, listCountLabel].forEach(titleStackView.addArrangedSubview(_:))
        [titleStackView, listTableView].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: listTableView.topAnchor, constant: -10),
            
            listTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            listCountLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            listCountLabel.widthAnchor.constraint(greaterThanOrEqualTo: listCountLabel.heightAnchor)
        ])
    }
    
    func configureBackgroundColor() {
        listTableView.backgroundColor = .clear
    }
    
    func updateCountLabel(_ count: Int) {
        listCountLabel.text = count.description
    }
}

private enum Constant {
    static let spacing: CGFloat = 10
}
