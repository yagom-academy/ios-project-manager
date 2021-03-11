//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    private let todoTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
    private let doingTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
    private let doneTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
    private let todoHeaderView = ThingTableHeaderView(height: 50, title: "TODO")
    private let doingHeaderView = ThingTableHeaderView(height: 50, title: "DOING")
    private let doneHeaderView = ThingTableHeaderView(height: 50, title: "DONE")
    private lazy var navigationDetailViewController: UINavigationController = {
        let detailViewController = DetailViewController()
        let navigationDetailViewController = UINavigationController(rootViewController: detailViewController)
        navigationDetailViewController.modalPresentationStyle = .formSheet
        return navigationDetailViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        configureTableView()
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationItem.title = "Project Manager"
        navigationController?.setToolbarHidden(false, animated: false)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.touchUpAddButton))
        navigationItem.setRightBarButton(addButton, animated: false)
    }
    
    private func configureTableView() {
        view.addSubview(todoTableView)
        view.addSubview(doingTableView)
        view.addSubview(doneTableView)
        todoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
        todoTableView.dragDelegate = self
        todoTableView.dropDelegate = self
        doingTableView.dragDelegate = self
        doingTableView.dropDelegate = self
        doneTableView.dragDelegate = self
        doneTableView.dropDelegate = self
        todoTableView.tableHeaderView = todoHeaderView
        doingTableView.tableHeaderView = doingHeaderView
        doneTableView.tableHeaderView = doneHeaderView
        todoTableView.sectionHeaderHeight = 2
        todoTableView.sectionFooterHeight = 2
        doingTableView.sectionHeaderHeight = 2
        doingTableView.sectionFooterHeight = 2
        doneTableView.sectionHeaderHeight = 2
        doneTableView.sectionFooterHeight = 2
        todoTableView.register(ThingTableViewCell.self, forCellReuseIdentifier: ThingTableViewCell.reuseIdentifier)
        doingTableView.register(ThingTableViewCell.self, forCellReuseIdentifier: ThingTableViewCell.reuseIdentifier)
        doneTableView.register(ThingTableViewCell.self, forCellReuseIdentifier: ThingTableViewCell.reuseIdentifier)
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        doingTableView.translatesAutoresizingMaskIntoConstraints = false
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
        todoTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -4).isActive = true
        doingTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -4).isActive = true
        doneTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -4).isActive = true
        todoTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        doingTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        doneTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        doingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        doneTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        todoTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        doingTableView.leftAnchor.constraint(equalTo: todoTableView.rightAnchor, constant: 6).isActive = true
        doneTableView.leftAnchor.constraint(equalTo: doingTableView.rightAnchor, constant: 6).isActive = true
    }
    
    @IBAction func touchUpAddButton() {
        guard let detailViewController = navigationDetailViewController.viewControllers.first as? DetailViewController else {
            return
        }
        detailViewController.isNew = true
        present(navigationDetailViewController, animated: true, completion: nil)
    }
}

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThingTableViewCell.reuseIdentifier, for: indexPath) as? ThingTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.section
        switch tableView { // TODO: list에서 indexPath.row 개수 검사 후 접근하도록 수정
        case todoTableView:
            let thing = Things.shared.todoList[index]
            cell.setContents(thing, false)
        case doingTableView:
            let thing = Things.shared.doingList[index]
            cell.setContents(thing, false)
        case doneTableView:
            let thing = Things.shared.doneList[index]
            cell.setContents(thing, true)
        default:
            break
        }
        return cell
    }
}

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
            return [UIDragItem(itemProvider: NSItemProvider())] // TODO: 임시로 해놓은거니깐 바꿔야됨.
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completionHandler: () -> Void = {
            let indexSet = IndexSet(indexPath.section...indexPath.section)
            DispatchQueue.main.async {
                tableView.deleteSections(indexSet, with: .automatic)
            }
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            switch tableView {
            case self.todoTableView:
                Things.shared.removeTodo(at: indexPath.section, completionHandler)
            case self.doingTableView:
                Things.shared.removeDoing(at: indexPath.section, completionHandler)
            case self.doneTableView:
                Things.shared.removeDone(at: indexPath.section, completionHandler)
            default:
                break
            }
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeAction
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = navigationDetailViewController.viewControllers.first as? DetailViewController else {
            return
        }
        let index = indexPath.section
        switch tableView { // TODO: list에서 indexPath.row 개수 검사 후 접근하도록 수정
        case todoTableView:
            let thing = Things.shared.todoList[index]
            detailViewController.setContents(thing, "TODO")
        case doingTableView:
            let thing = Things.shared.doingList[index]
            detailViewController.setContents(thing, "DOING")
        case doneTableView:
            let thing = Things.shared.doneList[index]
            detailViewController.setContents(thing, "DONE")
        default:
            break
        }
        present(navigationDetailViewController, animated: true, completion: nil)
    }
}
