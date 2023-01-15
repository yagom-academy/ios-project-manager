//
//  ListView.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/11.
//

import UIKit

class ListView: UIView {
    let category: Category
    
    let viewModel: ListViewModel?
    
    let stackView: UIStackView = {
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
    
    let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = category.description
        return label
    }()
    
    lazy var categoryCountLabel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = button.layer.frame.width / 2
        button.tintColor = .white
        return button
    }()
    
    let blankView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(category: Category, workManager: WorkManager) {
        self.category = category
        viewModel = ListViewModel(workManager: workManager)
        super.init(frame: CGRect())
        confgiureLayout()
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel?.workTodoList { _ in
            self.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confgiureLayout() {
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

extension ListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.workList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath)
                as? ListCell else { return ListCell() }
        
        cell.configureData(work: viewModel!.workList[indexPath.row])
        return cell
    }
}
