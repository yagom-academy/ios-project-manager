//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Outlet
    
    private lazy var todoTableView = ThingTableView(tableViewType: .todo, mainViewController: self)
    private lazy var doingTableView = ThingTableView(tableViewType: .doing, mainViewController: self)
    private lazy var doneTableView = ThingTableView(tableViewType: .done, mainViewController: self)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureConstratins()
        registerNotificationCentor()
    }
    
    // MARK: - UI
    
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
        navigationItem.titleView = MainTitleView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Strings.historyButton, style: .plain, target: self, action: #selector(touchUpHistoryButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchUpAddButton))
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @objc private func touchUpHistoryButton(_ sender: AnyObject) {
        let popOver = HistoryTableViewController()
        popOver.modalPresentationStyle = .popover
        popOver.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        present(popOver, animated: true, completion: nil)
    }
    
    // MARK: - DetailView
    
    @IBAction private func touchUpAddButton() {
        showDetailView(isNew: true)
    }
    
    private func showDetailView(isNew: Bool = false, tableViewType: TableViewType = .todo, index: Int? = nil, thing: Thing? = nil) {
        let detailView = DetailViewController()
        let navigationController = UINavigationController(rootViewController: detailView)
        detailView.title = tableViewType.rawValue
        detailView.isNew = isNew
        detailView.index = index
        detailView.thing = thing
        detailView.tableViewType = tableViewType
        present(navigationController, animated: true, completion: nil)
    }
    
    private func registerNotificationCentor() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTodoTableView), name: Notification.Name(TableViewType.todo.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDoingTableView), name: Notification.Name(TableViewType.doing.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDoneTableView), name: Notification.Name(TableViewType.done.rawValue), object: nil)
    }
    
    @objc private func reloadTodoTableView() {
        todoTableView.reloadData()
    }
    
    @objc private func reloadDoingTableView() {
        doingTableView.reloadData()
    }
    
    @objc private func reloadDoneTableView() {
        doneTableView.reloadData()
    }
}

// MARK: - Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableViewType = (tableView as? ThingTableView)?.tableViewType else {
            return
        }
        let index = indexPath.row
        let thing = Things.shared.getThing(at: index, tableViewType)
        showDetailView(tableViewType: tableViewType, index: index, thing: thing)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let tableViewType = (tableView as? ThingTableView)?.tableViewType else {
                return
            }
            let index = indexPath.row
            Things.shared.deleteThing(at: index, tableViewType) {
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
            }
        }
    }
}

// MARK: - DataSoure

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let thingTableView = tableView as? ThingTableView else {
            return 0
        }
        let tableViewType = thingTableView.tableViewType
        let thingsCount = Things.shared.getThingListCount(tableViewType)
        thingTableView.setCount(thingsCount)
        return thingsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ThingTableViewCell.self)
        let index = indexPath.row
        guard let tableViewType = (tableView as? ThingTableView)?.tableViewType,
              let thing = Things.shared.getThing(at: index, tableViewType) else {
            return cell
        }
        cell.configureCell(thing)
        return cell
    }
}

// MARK: - Drag & Drop

extension MainViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let thingTableView = tableView as? ThingTableView else {
            return [UIDragItem(itemProvider: NSItemProvider())]
        }
        return thingTableView.drag(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        var indexPath: IndexPath
        if let destinationIndexPath = coordinator.destinationIndexPath {
            indexPath = destinationIndexPath
        } else {
            var section = tableView.numberOfSections
            if section > 0 {
                section -= 1
            }
            let row = tableView.numberOfRows(inSection: section)
            indexPath = IndexPath(row: row, section: section)
        }
        
        guard let thingTableView = tableView as? ThingTableView else {
            return
        }
        thingTableView.drop(coordinator.items, to: indexPath)
    }
}
