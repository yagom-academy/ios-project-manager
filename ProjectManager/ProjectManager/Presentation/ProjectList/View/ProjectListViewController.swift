//
//  ProjectListViewController.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/20.
//

import UIKit
import Combine

final class ProjectListViewController: UIViewController {
    
    // MARK: - Private Property
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray6
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let viewModel: ProjectListViewModel
    
    private var cancellables: [AnyCancellable] = []
    
    private let headerView = HeaderView()
    private let tableView = UITableView()
    
    private lazy var dataSource: UITableViewDiffableDataSource = {
        let dataSource = UITableViewDiffableDataSource<Section, Project>(tableView: tableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.identifier, for: indexPath) as? ProjectTableViewCell else {
                return UITableViewCell()
            }
            
            let viewModel = DefaultProjectTableViewCellViewModel(project: item)
            cell.setupViewModel(viewModel)
            
            return cell
        })
        
        return dataSource
    }()
    
    // MARK: - Life Cycle
    init(viewModel: ProjectListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View event
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupBindings()
    }
    
    @objc private func handleLongPressGesture(_ sender: UIGestureRecognizer) {
        let location = sender.location(in: tableView)
        
        viewModel.handleLongPressGesture(target: tableView, location: location)
    }
    
    // MARK: - Data Binding
    func setupBindings() {
        viewModel.projectsPublisher.sink { [weak self] projects in
            guard let self else {
                return
            }
            
            var snapShot = NSDiffableDataSourceSnapshot<Section, Project>()
            snapShot.appendSections([.main])
            snapShot.appendItems(projects)
            self.dataSource.apply(snapShot)
        }.store(in: &cancellables)
        
        viewModel.projectCountPublisher.sink { [weak self] count in
            guard let self else {
                return
            }
            
            self.configureHeaderView(count: count)
        }.store(in: &cancellables)
    }
}

// MARK: - TableView Delegate
extension ProjectListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            guard let self else {
                return
            }
            
            self.viewModel.deleteItem(at: indexPath.row)
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - Configure UI
extension ProjectListViewController {
    private func configureUI() {
        configureTableView()
        configureView()
        configureStackView()
        configureLayout()
    }
    
    private func configureTableView() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        
        tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.addGestureRecognizer(gesture)
    }
    
    private func configureView() {
        view.addSubview(stackView)
    }
    
    private func configureStackView() {
        [headerView, tableView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureHeaderView(count: Int) {
        headerView.configure(title: viewModel.navigationTitle, count: count)
    }
    
    private func configureLayout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
}

extension ProjectListViewController {
    private enum Section {
        case main
    }
}
