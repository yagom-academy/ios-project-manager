//
//  ListView.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/11.
//

import UIKit

final class ListView: UIView {
    private let category: Category

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.backgroundColor = .systemGray5
        return tableView
    }()
    
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = category.description
        return label
    }()
    
    private lazy var categoryCountLabel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = button.layer.frame.width / 2
        button.tintColor = .white
        return button
    }()
    
    private let blankView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(category: Category) {
        self.category = category
        super.init(frame: CGRect())
        confgiureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func confgiureLayout() {
        backgroundColor = .systemGray5
        categoryStackView.addArrangedSubview(categoryLabel)
        categoryStackView.addArrangedSubview(categoryCountLabel)
        categoryStackView.addArrangedSubview(blankView)
        stackView.addArrangedSubview(categoryStackView)
        stackView.addArrangedSubview(tableView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
