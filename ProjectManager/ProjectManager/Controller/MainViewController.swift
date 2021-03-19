//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Outlet
    
    private lazy var todoTableView = TodoTableView()
    private lazy var doingTableView = DoingTableView()
    private lazy var doneTableView = DoneTableView()
    private lazy var titleView = MainTitleView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureConstratins()
        configureThingTableViews()
        fetchData()
    }
    
    // MARK: - UI
    
    private func configureThingTableViews() {
        let thingTableViews = [todoTableView, doingTableView, doneTableView]
        for thingTableView in thingTableViews {
            thingTableView.dataSource = self
            thingTableView.delegate = self
            thingTableView.dragDelegate = self
            thingTableView.dropDelegate = self
            thingTableView.register(cellType: ThingTableViewCell.self)
        }
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
        navigationItem.titleView = titleView
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
    
    // MARK: - Fetch Data
    
    private func fetchData() {
        NetworkManager.fetch { result in
            switch result {
            case .success(let things):
                for thing in things {
                    if thing.state == Strings.todoState {
                        self.todoTableView.fetchList(thing.list)
                    } else if thing.state == Strings.doingState {
                        self.doingTableView.fetchList(thing.list)
                    } else if thing.state == Strings.doneState {
                        self.doneTableView.fetchList(thing.list)
                    }
                }
                self.titleView.isConnected = true
            case .failure(_):
                self.titleView.isConnected = false
            }
        }
    }
    
    // MARK: - DetailView
    
    @IBAction private func touchUpAddButton() {
        showDetailView(isNew: true, tableView: todoTableView)
    }
    
    private func showDetailView(isNew: Bool = false, index: Int? = nil, thing: Thing? = nil, tableView: ThingTableView? = nil) {
        let detailView = DetailViewController()
        let navigationController = UINavigationController(rootViewController: detailView)
        detailView.isNew = isNew
        detailView.index = index
        detailView.thing = thing
        detailView.tableView = tableView
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let thingTableView = tableView as? ThingTableView else {
            return
        }
        let thing = thingTableView.list[indexPath.row]
        showDetailView(index: indexPath.row, thing: thing, tableView: thingTableView)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let thingTableView = tableView as? ThingTableView else {
                return
            }
            let thing = thingTableView.list[indexPath.row]
            dump(thing)
            HistoryManager.insertRemoveHistory(title: thing.title, from: thingTableView)
            thingTableView.deleteThing(at: indexPath)
        }
    }
}

// MARK: - DataSoure

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let thingTableView = tableView as? ThingTableView else {
            return 0
        }
        thingTableView.setCount(thingTableView.list.count)
        return thingTableView.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let thingTableView = tableView as? ThingTableView else {
            return UITableViewCell()
        }
        let cell = thingTableView.dequeueReusableCell(for: indexPath, cellType: ThingTableViewCell.self)
        let thing = thingTableView.list[indexPath.row]
        cell.configureCell(thing)
        return cell
    }
}

// MARK: - Drag & Drop

extension MainViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let draggableTableView = tableView as? Draggable else {
            return [UIDragItem(itemProvider: NSItemProvider())]
        }
        return draggableTableView.drag(for: indexPath, tableView: draggableTableView)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        var indexPath: IndexPath
        if let destinationIndexPath = coordinator.destinationIndexPath {
            indexPath = destinationIndexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            indexPath = IndexPath(row: row, section: section)
        }
        guard let droppableTableView = tableView as? Droppable else {
            return
        }
        droppableTableView.drop(coordinator.items, to: indexPath, tableView: droppableTableView)
    }
}
