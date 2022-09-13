//
//  ProjectManagerViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/07.
//

import UIKit

private enum Design {
    static let mainStackViewSpacing: CGFloat = 8
    static let navigationTitle: String = "ProjectManager"
    static let tableViewdefaultRow = 0
    static let longPressGestureMinimumPressDuration = 1.0
    static let alertControllerDefaultTitle = ""
}

final class ProjectManagerViewController: UIViewController {
    private var dataManager = WorkDataManager().provider
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        
        configureLongPressGestureRecognizer()
        configureNavigationItems()
        configureStackViewLayout()
        configureTableViews()
    }
    
    private func configureLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture))
        longPress.minimumPressDuration = Design.longPressGestureMinimumPressDuration
        
        self.view.addGestureRecognizer(longPress)
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
    
    private func showAlert(view: UIView?, state: WorkState?, indexPath: IndexPath) {
        guard let state = state else { return }
        let alertController = UIAlertController(title: Design.alertControllerDefaultTitle,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        makeAlertAction(state: state, indexPath: indexPath).forEach { alertController.addAction($0) }
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.permittedArrowDirections = [.up]
        
        present(alertController, animated: false)
    }
    
    private func makeAlertAction(state: WorkState, indexPath: IndexPath) -> [UIAlertAction] {
        var firstActionHandler: ((UIAlertAction) -> Void)?
        var secondActionHandler: ((UIAlertAction) -> Void)?
        let item = dataManager.read(workState: state)[indexPath.row]
        
        switch state {
        case .todo:
            firstActionHandler = { [weak self] _ in self?.updateData(item: item,
                                                                     state: .doing) }
            secondActionHandler = { [weak self] _ in self?.updateData(item: item,
                                                                      state: .done) }
        case .doing:
            firstActionHandler = { [weak self] _ in self?.updateData(item: item,
                                                                     state: .todo) }
            secondActionHandler = { [weak self] _ in self?.updateData(item: item,
                                                                      state: .done) }
        case .done:
            firstActionHandler = { [weak self] _ in self?.updateData(item: item,
                                                                     state: .todo) }
            secondActionHandler = { [weak self] _ in self?.updateData(item: item,
                                                                      state: .doing) }
        }
        
        let firstAction = UIAlertAction(title: state.actionTitles.first,
                                        style: .default,
                                        handler: firstActionHandler)
        let secondAction = UIAlertAction(title: state.actionTitles.second,
                                         style: .default,
                                         handler: secondActionHandler)
        
        return [firstAction, secondAction]
    }
    
    private func updateData(item: WorkDTO, state: WorkState) {
        let newItem = WorkDTO(id: item.id,
                              title: item.title,
                              body: item.body,
                              date: item.date,
                              workState: state)
        
        dataManager.update(id: item.id, work: newItem)
        
        todoTableView.reloadData()
        doneTabelView.reloadData()
        doingTableView.reloadData()
    }
    
    private func configureNavigationItems() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(rightBarButtonDidTap))
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.title = Design.navigationTitle
    }
    
    @objc private func rightBarButtonDidTap() {
        let projectCreateViewController = ProjectCreateViewController()
        let navigationController = UINavigationController(rootViewController: projectCreateViewController)
        
        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
    }
    
    private func configureTableViews() {
        todoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTabelView.dataSource = self
        
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTabelView.delegate = self
        
        [todoTableView, doingTableView, doneTabelView].forEach {
            $0.register(WorkTableViewCell.self,
                        forCellReuseIdentifier: WorkTableViewCell.reuseIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkTableViewCell.reuseIdentifier)
                as? WorkTableViewCell
        else { return UITableViewCell() }
        
        var items: [WorkDTO]?
        
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
                      date: items?[indexPath.row].date.description)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        
        switch tableView {
        case todoTableView:
            view.setItems(title: WorkState.todo.name,
                          count: dataManager.read(workState: .todo).count.description)
        case doingTableView:
            view.setItems(title: WorkState.doing.name,
                          count: dataManager.read(workState: .doing).count.description)
        case doneTabelView:
            view.setItems(title: WorkState.done.name,
                          count: dataManager.read(workState: .done).count.description)
        default: break
        }
        
        return view
    }
}

extension ProjectManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let projectCreateViewController = ProjectCreateViewController()
        projectCreateViewController.item = dataManager.read()[indexPath.row]
        
        let navigationController = UINavigationController(rootViewController: projectCreateViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
}
