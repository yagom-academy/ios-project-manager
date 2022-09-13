//
//  ProjectManagerViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/07.
//

import UIKit

// MARK: - NameSpace

private enum Design {
    static let mainStackViewSpacing: CGFloat = 8
    static let navigationTitle: String = "PROJECT MANAGER"
    static let tableViewdefaultRow = 0
    static let longPressGestureMinimumPressDuration = 1.0
    static let alertControllerDefaultTitle = ""
    static let deleteSwipeActionTitle = "DELETE"
}

final class ProjectManagerViewController: UIViewController {
    // MARK: - Properties
    
    private var dataManager = ProjectDataManager().provider
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Design.mainStackViewSpacing
        stackView.backgroundColor = .systemGray5
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private let doneTabelView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        
        configureLongPressGestureRecognizer()
        configureNavigationItems()
        configureStackViewLayout()
        configureTableViews()
    }
    
    // MARK: - Methods
    
    private func configureLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture))
        longPress.minimumPressDuration = Design.longPressGestureMinimumPressDuration
        
        self.view.addGestureRecognizer(longPress)
    }
    
    private func showAlert(tableView: UITableView, indexPath: IndexPath) {
        let alertController = UIAlertController(title: Design.alertControllerDefaultTitle,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        makeAlertAction(tableView: tableView, indexPath: indexPath).forEach { alertController.addAction($0) }
        
        alertController.popoverPresentationController?.sourceView = tableView
        alertController.popoverPresentationController?.sourceRect = tableView.rectForRow(at: indexPath)
        alertController.popoverPresentationController?.permittedArrowDirections = [.up]
        
        present(alertController, animated: false)
    }
    
    private func makeAlertAction(tableView: UITableView, indexPath: IndexPath) -> [UIAlertAction] {
        guard let item = makeItem(tableView: tableView)?[indexPath.row] else { return [UIAlertAction]() }
        let actionHandlers = makeActionHandlers(tableView: tableView, item: item)
        let firstAction = UIAlertAction(title: item.workState.actionTitles.first,
                                        style: .default,
                                        handler: actionHandlers[0])
        let secondAction = UIAlertAction(title: item.workState.actionTitles.second,
                                         style: .default,
                                         handler: actionHandlers[1])
        
        return [firstAction, secondAction]
    }
    
    private func makeActionHandlers(tableView: UITableView,
                                    item: ProjectDTO) -> [((UIAlertAction) -> Void)?] {
        switch tableView {
        case todoTableView:
            return [ makeHandlers(item: item, to: .doing), makeHandlers(item: item, to: .done) ]
        case doingTableView:
            return [ makeHandlers(item: item, to: .todo), makeHandlers(item: item, to: .done) ]
        case doneTabelView:
            return [ makeHandlers(item: item, to: .todo), makeHandlers(item: item, to: .doing) ]
        default: return [nil]
        }
    }
    
    private func makeHandlers(item: ProjectDTO, to state: ProjectState) -> ((UIAlertAction) -> Void)? {
        return { [weak self] _ in self?.changeState(item: item, to: .todo) }
    }
    
    private func changeState(item: ProjectDTO, to state: ProjectState) {
        let newItem = ProjectDTO(id: item.id,
                                 title: item.title,
                                 body: item.body,
                                 date: item.date,
                                 workState: state)
        
        dataManager.update(id: item.id, work: newItem)
        
        tableViewsReloadData(todoTableView, doneTabelView, doingTableView)
    }
    
    private func configureNavigationItems() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(rightBarButtonDidTap))
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.title = Design.navigationTitle
    }
    
    private func tableViewsReloadData(_ tableViews: UITableView?...) {
        tableViews.forEach { $0?.reloadData() }
    }
    
    private func makeItem(tableView: UITableView) -> [ProjectDTO]? {
        switch tableView {
        case todoTableView:
            return dataManager.read().filter { $0.workState == .todo}
        case doingTableView:
            return dataManager.read().filter { $0.workState == .doing}
        case doneTabelView:
            return dataManager.read().filter { $0.workState == .done}
        default: return nil
        }
    }
    
    private func configurePresentNavigationController(item: ProjectDTO?) -> UINavigationController {
        let projectCreateViewController = ProjectUpdateViewController()
        projectCreateViewController.item = item
        projectCreateViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: projectCreateViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        return navigationController
    }
    
    @objc private func longPressGesture(sender: UILongPressGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        if let indexPath = todoTableView.indexPathForRow(at: sender.location(in: todoTableView)) {
            showAlert(tableView: todoTableView,
                      indexPath: indexPath)
        } else if let indexPath = doingTableView.indexPathForRow(at: sender.location(in: doingTableView)) {
            showAlert(tableView: doingTableView,
                      indexPath: indexPath)
        } else if let indexPath = doneTabelView.indexPathForRow(at: sender.location(in: doneTabelView)) {
            showAlert(tableView: doneTabelView,
                      indexPath: indexPath)
        }
    }
    
    @objc private func rightBarButtonDidTap() {
        let navigationController = configurePresentNavigationController(item: nil)
        
        present(navigationController, animated: true)
    }
    
    private func configureTableViews() {
        [todoTableView, doingTableView, doneTabelView].forEach {
            $0.dataSource = self
            $0.delegate = self
            $0.register(ProjectTableViewCell.self,
                        forCellReuseIdentifier: ProjectTableViewCell.reuseIdentifier)
        }
    }
    
    private func configureStackViewLayout() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainStackView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                mainStackView.leadingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                mainStackView.trailingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ]
        )
        
        [todoTableView, doingTableView, doneTabelView]
            .forEach { mainStackView.addArrangedSubview($0) }
    }
}

// MARK: - Extension UITableViewDataSource

extension ProjectManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = makeItem(tableView: tableView) else { return 0 }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reuseIdentifier)
                as? ProjectTableViewCell
        else { return UITableViewCell() }
        
        let items = makeItem(tableView: tableView)
        
        cell.setItems(title: items?[indexPath.row].title,
                      body: items?[indexPath.row].body,
                      date: items?[indexPath.row].date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ProjectTableHeaderView()
        
        let items = makeItem(tableView: tableView)
        
        switch tableView {
        case todoTableView:
            view.setItems(title: ProjectState.todo.name,
                          count: items?.count.description)
        case doingTableView:
            view.setItems(title: ProjectState.doing.name,
                          count: items?.count.description)
        case doneTabelView:
            view.setItems(title: ProjectState.done.name,
                          count: items?.count.description)
        default: break
        }
        
        return view
    }
}

// MARK: - Extension UITableViewDelegate

extension ProjectManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = makeItem(tableView: tableView)?[indexPath.row]
        
       let navigationController = configurePresentNavigationController(item: item)
        
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let item = makeItem(tableView: tableView)?[indexPath.row] else { return nil }
        
        let deleteSwipeAction = UIContextualAction(style: .destructive,
                                                   title: Design.deleteSwipeActionTitle,
                                                   handler: { [weak self] _, _, completionHaldler in
            self?.dataManager.delete(id: item.id)
            self?.tableViewsReloadData(self?.todoTableView, self?.doingTableView, self?.doneTabelView)
            completionHaldler(true)
        })
        
        return UISwipeActionsConfiguration(actions: [deleteSwipeAction])
    }
}

// MARK: - Extension ProjectManagerDataProtocol

extension ProjectManagerViewController: ProjectDataManagerProtocol {
    func create(data: ProjectDTO) {
        dataManager.append(work: data)
        
        tableViewsReloadData(todoTableView)
    }
    
    func update(id: String, data: ProjectDTO) {
        dataManager.update(id: id, work: data)
        
        tableViewsReloadData(todoTableView, doingTableView, doneTabelView)
    }
}
