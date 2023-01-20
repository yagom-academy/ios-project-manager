//
//  ListView.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/11.
//

import UIKit

final class ListView: UIView {
    let viewModel: ListViewModel
    
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
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()
    
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: .zero, right: 10)
        stackView.spacing = 5
        return stackView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let categoryCountLabel: CircleLabel = {
        let label = CircleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let blankView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect())
        configureBind()
        configureLayout()
        configureData()
        backgroundColor = .systemGray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureData() {
        categoryLabel.text = viewModel.category.description
        viewModel.load()
    }
    
    func didChangeCountValue(count: Int) {
        viewModel.categoryCount = count
    }
    
    private func configureBind() {
        viewModel.bindCount { [weak self] in
            self?.categoryCountLabel.text = $0.description
            self?.tableView.reloadData()
        }
    }
    
    private func configureLayout() {
        categoryStackView.addArrangedSubview(categoryLabel)
        categoryStackView.addArrangedSubview(categoryCountLabel)
        categoryStackView.addArrangedSubview(blankView)
        stackView.addArrangedSubview(categoryStackView)
        stackView.addArrangedSubview(lineView)
        stackView.addArrangedSubview(tableView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
