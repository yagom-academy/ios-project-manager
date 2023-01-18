//
//  ProjectListViewController.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/17.
//

import UIKit

final class ProjectListViewController: UIViewController {
    private enum Section {
        case main
    }
    
    private let header: HeaderView
    private let tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section, Project>?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    init(state: State) {
        header = HeaderView(title: state.name)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.reuseIdentifier)
        configureDataSource()
    }
}

// MARK: Diffable DataSource
extension ProjectListViewController {
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Project>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, project in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ProjectCell.reuseIdentifier,
                    for: indexPath
                ) as? ProjectCell else {
                    return UITableViewCell()
                }
                
                cell.configureComponents(with: project)
                
                return cell
            })
    }
    
    func updateList(with data: [Project]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Project>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot)
    }
}

// MARK: UI Configure
extension ProjectListViewController {
    private func configureView() {
        tableView.backgroundColor = .systemGray6
        
        [header, tableView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
    }
    
    private func configureLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            header.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.09)
        ])
    }
}
