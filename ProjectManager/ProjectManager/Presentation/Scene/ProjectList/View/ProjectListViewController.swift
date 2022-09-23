//
//  ProjectListViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/07.
//

import UIKit

// MARK: - NameSpace

private enum Design {
    static let navigationTitle = "PROJECT MANAGER"
    static let longPressGestureMinimumPressDuration = 1.0
}

final class ProjectListViewController: UIViewController {
    // MARK: - Properties
    
    private var viewModel = ProjectListViewModel()
    private let mainView = ProjcetListView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObserverBind()
        configureLongPressGestureRecognizer()
        configureNavigationItems()
        configureMainView()
    }
    
    // MARK: - Methods
    
    private func configureObserverBind() {
        viewModel.todoListObserverBind { [weak self] _ in
            DispatchQueue.main.async {
                self?.mainView.retrieveTableView(with: .todo).reloadData()
            }
        }
        
        viewModel.doingListObserverBind { [weak self] _ in
            DispatchQueue.main.async {
                self?.mainView.retrieveTableView(with: .doing).reloadData()
            }
        }
        
        viewModel.doneListObserverBind { [weak self] _ in
            DispatchQueue.main.async {
                self?.mainView.retrieveTableView(with: .done).reloadData()
            }
        }
    }
    
    private func retrieveState(tableView: UITableView) -> ProjectState? {
        switch tableView {
        case mainView.retrieveTableView(with: .todo):
            return .todo
        case mainView.retrieveTableView(with: .doing):
            return .doing
        case mainView.retrieveTableView(with: .done):
            return .done
        default:
            return nil
        }
    }
    
    private func configureLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(longPressDidTap))
        longPress.minimumPressDuration = Design.longPressGestureMinimumPressDuration
        
        view.addGestureRecognizer(longPress)
    }
    
    @objc private func longPressDidTap(sender: UILongPressGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        ProjectState.allCases.forEach {
            let tableView = mainView.retrieveTableView(with: $0)
            guard let indexPath = tableView.indexPathForRow(at: sender.location(in: tableView))
            else { return }
            
            let alertController = viewModel.makeAlertContoller(tableView: tableView,
                                                               indexPath: indexPath,
                                                               state: $0)
            
            present(alertController, animated: false)
        }
    }
    
    private func configureNavigationItems() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(rightBarButtonDidTap))
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.title = Design.navigationTitle
    }
    
    @objc private func rightBarButtonDidTap() {
        let navigationController = makeNavigationController(item: nil)
        
        present(navigationController, animated: true)
    }
    
    private func makeNavigationController(item: ProjectViewModel?) -> UINavigationController {
        let projectManagementViewController = ProjectManagementViewController()
        projectManagementViewController.item = item
        projectManagementViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: projectManagementViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        return navigationController
    }
    
    private func configureMainView() {
        view = mainView
        mainView.backgroundColor = .systemBackground
        mainView.rootViewController = self
        mainView.configureTableViews()
    }
}

// MARK: - Extension UITableViewDataSource

extension ProjectListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let state = retrieveState(tableView: tableView) else { return 0 }
        
        return viewModel.configureNumberOfRow(state: state)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reuseIdentifier)
                as? ProjectTableViewCell,
              let state = retrieveState(tableView: tableView)
        else { return UITableViewCell() }
        
        viewModel.configureCellItem(cell: cell,
                                    state: state,
                                    indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard let state = retrieveState(tableView: tableView) else { return nil }
        
        return viewModel.makeTableHaederView(state: state)
    }
}

// MARK: - Extension UITableViewDelegate

extension ProjectListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard let state = retrieveState(tableView: tableView) else { return }
        
        tableView.deselectRow(at: indexPath,
                              animated: false)
        
        let item = viewModel.retrieveItems(state: state)[indexPath.row]
        let navigationController = makeNavigationController(item: item)
        
        present(navigationController,
                animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let state = retrieveState(tableView: tableView) else { return nil }
        
        let deleteSwipeActions = viewModel.makeSwipeActions(state: state,
                                                            indexPath: indexPath)
        
        return UISwipeActionsConfiguration(actions: deleteSwipeActions)
    }
}

// MARK: - Extension ProjectManagerDataProtocol

extension ProjectListViewController: ProjectManagementViewControllerDelegate {
    func projectManagementViewController(_ viewController: ProjectManagementViewController,
                                         createData: ProjectViewModel) {
        viewModel.create(data: createData)
    }
    func projectManagementViewController(_ viewController: ProjectManagementViewController,
                                         updateData: ProjectViewModel) {
        viewModel.update(id: updateData.id,
                         data: updateData)
    }
}
