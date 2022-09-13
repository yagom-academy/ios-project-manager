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
    
    private func showAlert(view: UIView?, state: ProjectState?, indexPath: IndexPath) {
        guard let state = state else { return }
        let alertController = UIAlertController(title: Design.alertControllerDefaultTitle,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        makeAlertAction(state: state, indexPath: indexPath).forEach { alertController.addAction($0) }
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.permittedArrowDirections = [.up]
        
        present(alertController, animated: false)
    }
    
    private func makeAlertAction(state: ProjectState, indexPath: IndexPath) -> [UIAlertAction] {
        var firstActionHandler: ((UIAlertAction) -> Void)?
        var secondActionHandler: ((UIAlertAction) -> Void)?
        let item = dataManager.read(workState: state)[indexPath.row]
        
        switch state {
        case .todo:
            firstActionHandler = { [weak self] _ in self?.changeState(item: item,
                                                                     to: .doing) }
            secondActionHandler = { [weak self] _ in self?.changeState(item: item,
                                                                      to: .done) }
        case .doing:
            firstActionHandler = { [weak self] _ in self?.changeState(item: item,
                                                                     to: .todo) }
            secondActionHandler = { [weak self] _ in self?.changeState(item: item,
                                                                      to: .done) }
        case .done:
            firstActionHandler = { [weak self] _ in self?.changeState(item: item,
                                                                     to: .todo) }
            secondActionHandler = { [weak self] _ in self?.changeState(item: item,
                                                                      to: .doing) }
        }
        
        let firstAction = UIAlertAction(title: state.actionTitles.first,
                                        style: .default,
                                        handler: firstActionHandler)
        let secondAction = UIAlertAction(title: state.actionTitles.second,
                                         style: .default,
                                         handler: secondActionHandler)
        
        return [firstAction, secondAction]
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
    
    @objc private func longPressGesture(sender: UILongPressGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        if let indexPath = todoTableView.indexPathForRow(at: sender.location(in: todoTableView)) {
            showAlert(view: todoTableView.cellForRow(at: indexPath),
                      state: .todo,
                      indexPath: indexPath)
        } else if let indexPath = doingTableView.indexPathForRow(at: sender.location(in: doingTableView)) {
            showAlert(view: doingTableView.cellForRow(at: indexPath),
                      state: .doing,
                      indexPath: indexPath)
        } else if let indexPath = doneTabelView.indexPathForRow(at: sender.location(in: doneTabelView)) {
            showAlert(view: doneTabelView.cellForRow(at: indexPath),
                      state: .done,
                      indexPath: indexPath)
        }
    }
    
    @objc private func rightBarButtonDidTap() {
        let projectCreateViewController = ProjectUpdateViewController()
        projectCreateViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: projectCreateViewController)
        navigationController.modalPresentationStyle = .formSheet
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
        switch tableView {
        case todoTableView:
            return dataManager.read(workState: .todo).count
        case doingTableView:
            return dataManager.read(workState: .doing).count
        case doneTabelView:
            return dataManager.read(workState: .done).count
        default:
            return Design.tableViewdefaultRow
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reuseIdentifier)
                as? ProjectTableViewCell
        else { return UITableViewCell() }
        
        var items: [ProjectDTO]?
        
        switch tableView {
        case todoTableView:
            items = dataManager.read(workState: .todo)
        case doingTableView:
            items = dataManager.read(workState: .doing)
        case doneTabelView:
            items = dataManager.read(workState: .done)
        default: break
        }
        
        cell.setItems(title: items?[indexPath.row].title,
                      body: items?[indexPath.row].body,
                      date: items?[indexPath.row].date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ProjectTableHeaderView()
        
        switch tableView {
        case todoTableView:
            view.setItems(title: ProjectState.todo.name,
                          count: dataManager.read(workState: .todo).count.description)
        case doingTableView:
            view.setItems(title: ProjectState.doing.name,
                          count: dataManager.read(workState: .doing).count.description)
        case doneTabelView:
            view.setItems(title: ProjectState.done.name,
                          count: dataManager.read(workState: .done).count.description)
        default: break
        }
        
        return view
    }
}

// MARK: - Extension UITableViewDelegate

extension ProjectManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let projectCreateViewController = ProjectUpdateViewController()
        projectCreateViewController.item = dataManager.read()[indexPath.row]
        projectCreateViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: projectCreateViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var items: ProjectDTO
        
        switch tableView {
        case todoTableView:
            items = dataManager.read(workState: .todo)[indexPath.row]
        case doingTableView:
            items = dataManager.read(workState: .doing)[indexPath.row]
        case doneTabelView:
            items = dataManager.read(workState: .done)[indexPath.row]
        default: return nil
        }
        
        let deleteSwipeAction = UIContextualAction(style: .destructive,
                                                   title: "Delete",
                                                   handler: { [weak self] _, _, completionHaldler in
            self?.dataManager.delete(id: items.id)
            self?.tableViewsReloadData(self?.todoTableView, self?.doingTableView, self?.doneTabelView)
            completionHaldler(true)
        })
        
        return UISwipeActionsConfiguration(actions: [deleteSwipeAction])
    }
}

// MARK: - Extension ProjectManagerDataProtocol

extension ProjectManagerViewController: ProjectManagerDataProtocol {
    func create(data: ProjectDTO) {
        dataManager.append(work: data)
        
        tableViewsReloadData(todoTableView)
    }
    
    func update(id: String, data: ProjectDTO) {
        dataManager.update(id: id, work: data)
        
        tableViewsReloadData(todoTableView, doingTableView, doneTabelView)
    }
}
