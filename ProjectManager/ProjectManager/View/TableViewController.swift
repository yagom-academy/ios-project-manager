//
//  TableViewController.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/23.
//

import UIKit

class TableViewController: UIViewController {
    private let listViewModel = ListViewModel()
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray3
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(CustomTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CustomTableViewHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(CustomTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CustomTableViewHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let doneTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(CustomTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CustomTableViewHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSubviews()
        configureConstraints()
        configureNavigation()
        addNotificationObserver()
    }
    
    private func configureSubviews() {
        view.addSubview(tableStackView)
        tableStackView.addArrangedSubview(todoTableView)
        tableStackView.addArrangedSubview(doingTableView)
        tableStackView.addArrangedSubview(doneTableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        let tables = [todoTableView, doingTableView, doneTableView]
        tables.forEach({
            $0.dataSource = self
            $0.delegate = self
        })
    }
    
    private func configureNavigation() {
        title = NameSpace.projectName
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addProject))
        
        navigationItem.rightBarButtonItem = addProjectButton
    }
    
    private func configureBinding() {

    }
    
    private func addNotificationObserver() {
        let tableviews = [todoTableView, doingTableView, doneTableView]
        NotificationCenter.default.addObserver(forName: .init("reload"),
                                               object: nil,
                                               queue: .main) { _ in
            tableviews.forEach({ $0.reloadData() })
        }
    }
    
    @objc
    private func addProject() {
        let detailProjectViewController = DetailProjectViewController(isNewList: true)
        detailProjectViewController.modalPresentationStyle = .formSheet
        let modalViewWithNavigation = UINavigationController(rootViewController: detailProjectViewController)
        navigationController?.present(modalViewWithNavigation, animated: true)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case todoTableView:
            return listViewModel.countProject(in: .Todo)
        case doingTableView:
            return listViewModel.countProject(in: .Doing)
        case doneTableView:
            return listViewModel.countProject(in: .Done)
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case todoTableView:
            guard let cell = todoTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
                return TableViewCell()
            }
            listViewModel.configureCell(to: cell, with: listViewModel.listArray.filter({ $0.state == .Todo })[indexPath.row])
            
            return cell
            
        case doingTableView:
            guard let cell = doingTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
                return TableViewCell()
            }
            listViewModel.configureCell(to: cell, with: listViewModel.listArray.filter({ $0.state == .Doing })[indexPath.row])
            
            return cell
            
        case doneTableView:
            guard let cell = doneTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
                return TableViewCell()
            }
            listViewModel.configureCell(to: cell, with: listViewModel.listArray.filter({ $0.state == .Done })[indexPath.row])
            
            return cell
        default:
            return TableViewCell()
        }
     }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case todoTableView:
            let header = todoTableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableViewHeader.identifier) as? CustomTableViewHeader
            header?.configureContent(state: State.Todo, data: listViewModel.listArray)
            
            return header
        case doingTableView:
            let header = doingTableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableViewHeader.identifier) as? CustomTableViewHeader
            header?.configureContent(state: State.Doing, data: listViewModel.listArray)
            
            return header
        case doneTableView:
            let header = doneTableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableViewHeader.identifier) as? CustomTableViewHeader
            header?.configureContent(state: State.Done, data: listViewModel.listArray)
            
            return header
        default:
            return CustomTableViewHeader()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailProjectViewController = DetailProjectViewController(isNewList: false)
        detailProjectViewController.modalPresentationStyle = .formSheet
        let modalViewWithNavigation = UINavigationController(rootViewController: detailProjectViewController)
        navigationController?.present(modalViewWithNavigation, animated: true)
        
        switch tableView {
        case todoTableView:
            tableView.deselectRow(at: indexPath, animated: true)
            detailProjectViewController.configureContent(with: listViewModel.listArray.filter({$0.state == .Todo })[indexPath.row])

        case doingTableView:
            tableView.deselectRow(at: indexPath, animated: true)
            detailProjectViewController.configureContent(with: listViewModel.listArray.filter({$0.state == .Doing })[indexPath.row])

        case doneTableView:
            tableView.deselectRow(at: indexPath, animated: true)
            detailProjectViewController.configureContent(with: listViewModel.listArray.filter({$0.state == .Done })[indexPath.row])

        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                        title: NameSpace.delete) { action, view, handler in
            self.listViewModel.delete(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

private enum NameSpace {
    static let projectName = "Project Manager"
    static let delete = "Delete"
}
