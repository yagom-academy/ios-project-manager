//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Outlet
    
    private lazy var todoTableView = makeTableView()
    private lazy var doingTableView = makeTableView()
    private lazy var doneTableView = makeTableView()
    private let todoHeaderView = ThingTableHeaderView(height: 50, tableViewType: .todo)
    private let doingHeaderView = ThingTableHeaderView(height: 50, tableViewType: .done)
    private let doneHeaderView = ThingTableHeaderView(height: 50, tableViewType: .doing)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureConstratins()
        registerNotificationCentor()
        setTableHeaderView()
    }
    
    // MARK: - UI
    private func setTableHeaderView() {
        todoTableView.tableHeaderView = todoHeaderView
        doingTableView.tableHeaderView = doingHeaderView
        doneTableView.tableHeaderView = doneHeaderView
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.sectionHeaderHeight = 2
        tableView.sectionFooterHeight = 2
        tableView.register(ThingTableViewCell.self, forCellReuseIdentifier: ThingTableViewCell.identifier)
        return tableView
    }
    
    private func configureConstratins() {
        let safeArea = view.safeAreaLayoutGuide
        let stackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Strings.navigationTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Strings.historyButton, style: .plain, target: self, action: #selector(touchUpHistoryButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchUpAddButton))
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @objc private func touchUpHistoryButton() {
        // TODO: history popOver
    }
    
    // MARK: - DetailView
    
    @IBAction private func touchUpAddButton() {
        showDetailView(isNew: true)
    }
    
    private func showDetailView(isNew: Bool = false, tableViewType: TableViewType = .todo, index: Int? = nil, thing: Thing? = nil) {
        let detailView = DetailViewController()
        let navigationController = UINavigationController(rootViewController: detailView)
        detailView.isNew = isNew
        detailView.title = tableViewType.rawValue
        detailView.tableViewType = tableViewType
        detailView.index = index
        detailView.thing = thing
        present(navigationController, animated: true, completion: nil)
    }
    
    private func registerNotificationCentor() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name(Strings.reloadData), object: nil)
    }
    
    @objc private func reloadTableView() {
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
}

// MARK: - Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.section
        if tableView == todoTableView {
            let thing = Things.shared.todoList[index]
            showDetailView(index: index, thing: thing)
        } else if tableView == doingTableView {
            let thing = Things.shared.doingList[index]
            showDetailView(tableViewType: .doing, index: index, thing: thing)
        } else {
            let thing = Things.shared.doneList[index]
            showDetailView(tableViewType: .done, index: index, thing: thing)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.section
            if tableView == todoTableView {
                Things.shared.todoList.remove(at: index)
            } else if tableView == doingTableView {
                Things.shared.doingList.remove(at: index)
            } else {
                Things.shared.doneList.remove(at: index)
            }
            let indexSet = IndexSet(index...index)
            tableView.deleteSections(indexSet, with: .automatic)
        }
    }
}


// MARK: - DataSoure

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 5
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case todoTableView:
            let todoCount = Things.shared.todoList.count
            todoHeaderView.setCount(todoCount)
            return todoCount
        case doingTableView:
            let doingCount = Things.shared.doingList.count
            doingHeaderView.setCount(doingCount)
            return doingCount
        case doneTableView:
            let doneCount = Things.shared.doneList.count
            doneHeaderView.setCount(doneCount)
            return doneCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case todoTableView:
            return 1
        case doingTableView:
            return 1
        case doneTableView:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThingTableViewCell.identifier) as? ThingTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.section
        switch tableView {
        case todoTableView:
            if index < Things.shared.todoList.count {
                cell.configureCell(Things.shared.todoList[index])
            }
        case doingTableView:
            if index < Things.shared.doingList.count {
                cell.configureCell(Things.shared.doingList[index])
            }
        case doneTableView:
            if index < Things.shared.doneList.count {
                cell.isDone = true
                cell.configureCell(Things.shared.doneList[index])
            }
        default:
            break
        }
        return cell
    }
}

// MARK: - Drag & Drop

extension MainViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        switch tableView {
        case todoTableView:
            return Things.shared.dragTodo(for: indexPath, tableView: tableView)
        case doingTableView:
            return Things.shared.dragDoing(for: indexPath, tableView: tableView)
        case doneTableView:
            return Things.shared.dragDone(for: indexPath, tableView: tableView)
        default:
            return [UIDragItem(itemProvider: NSItemProvider())]
        }
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections
            destinationIndexPath = IndexPath(row: 0, section: section)
        }
        switch tableView {
        case todoTableView:
            Things.shared.dropTodo(coordinator.items, tableView: tableView, destinationIndexPath: destinationIndexPath)
        case doingTableView:
            Things.shared.dropDoing(coordinator.items, tableView: tableView, destinationIndexPath: destinationIndexPath)
        case doneTableView:
            Things.shared.dropDone(coordinator.items, tableView: tableView, destinationIndexPath: destinationIndexPath)
        default:
            break
        }
    }
}
