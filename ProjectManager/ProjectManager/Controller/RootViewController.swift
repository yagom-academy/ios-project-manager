//
//  ProjectManager - RootViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class RootViewController: UIViewController {
    private var todo: [ProjectManager] = []
    private var doing: [ProjectManager] = []
    private var done: [ProjectManager] = []
    
    private let todoTitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .systemBackground
        titleView.configureTitleLabel(text: "TODO")
        
        return titleView
    }()
    
    private let doingTitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .systemBackground
        titleView.configureTitleLabel(text: "DOING")
        
        return titleView
    }()
    
    private let doneTitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .systemBackground
        titleView.configureTitleLabel(text: "DONE")
        
        return titleView
    }()
    
    private let todoTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewTag.todo.description)
        tableView.tag = TableViewTag.todo.tag
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewTag.doing.description)
        tableView.tag = TableViewTag.doing.tag
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let doneTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewTag.done.description)
        tableView.tag = TableViewTag.done.tag
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        configureLayout()
        
    }
    
    func configureNavigation() {
        let plusBotton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(tappedPlusButton))
        navigationItem.rightBarButtonItem = plusBotton
        navigationItem.title = "Project Manager"
    }
    private func configureUI() {
        view.backgroundColor = .systemGray6
        todoTableView.delegate = self
        todoTableView.dataSource = self
        doingTableView.delegate = self
        doingTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.dataSource = self
        view.addSubview(todoTitleView)
        view.addSubview(doingTitleView)
        view.addSubview(doneTitleView)
        view.addSubview(todoTableView)
        view.addSubview(doingTableView)
        view.addSubview(doneTableView)
    }
    
    private func configureLayout() {
        let viewWidth = view.safeAreaLayoutGuide.layoutFrame.width / 3.0
        
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: todoTitleView.bottomAnchor, constant: 8),
            todoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoTableView.widthAnchor.constraint(equalToConstant: viewWidth),
            todoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            doingTableView.topAnchor.constraint(equalTo: doingTitleView.bottomAnchor, constant: 8),
            doingTableView.leadingAnchor.constraint(equalTo: todoTableView.trailingAnchor),
            doingTableView.widthAnchor.constraint(equalToConstant: viewWidth),
            doingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            doneTableView.topAnchor.constraint(equalTo: doneTitleView.bottomAnchor, constant: 8),
            doneTableView.leadingAnchor.constraint(equalTo: doingTableView.trailingAnchor),
            doneTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            doneTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            todoTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todoTitleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            todoTitleView.bottomAnchor.constraint(equalTo: todoTableView.topAnchor),
            
            doingTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            doingTitleView.leadingAnchor.constraint(equalTo: todoTableView.trailingAnchor),
            doingTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            doingTitleView.bottomAnchor.constraint(equalTo: doingTableView.topAnchor),
            
            doneTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            doneTitleView.leadingAnchor.constraint(equalTo: doingTableView.trailingAnchor),
            doneTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            doneTitleView.bottomAnchor.constraint(equalTo: doneTableView.topAnchor)
            
        ])
    }
    
    @objc private func tappedPlusButton() {
        let newTODOViewController: TODOViewController = TODOViewController(writeMode: .new, text: ProjectManager(), tableViewTag: TableViewTag.todo.tag, indexPath: nil)
        newTODOViewController.modalPresentationStyle = .formSheet
        newTODOViewController.delegate = self
        let navigationController: UINavigationController = UINavigationController(rootViewController: newTODOViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func longTappedCell(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? UITableViewCell else {
            return
        }
        
        guard let tableView = cell.superview as? UITableView else {
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let moveToDo = UIAlertAction(title: "move to TODO", style: .default) { [weak self] _ in
            if tableView.tag == TableViewTag.doing.tag {
                guard let indexPath = self?.doingTableView.indexPath(for: cell),
                      let doingText = self?.doing[safe: indexPath.row] else {
                    return
                }
                
                self?.todo.append(doingText)
                self?.doing.remove(at: indexPath.row)
                self?.doingTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.todo.count else {
                    return
                }
                
                let index = IndexPath(row: count - 1, section: 0)
                self?.todoTableView.insertRows(at: [index], with: .automatic)
            }
            
            if tableView.tag == TableViewTag.done.tag {
                guard let indexPath = self?.doneTableView.indexPath(for: cell),
                      let doneText = self?.done[safe: indexPath.row] else {
                    return
                }
                
                self?.todo.append(doneText)
                self?.done.remove(at: indexPath.row)
                self?.doneTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.todo.count else {
                    return
                }
                
                let index = IndexPath(row: count - 1, section: 0)
                self?.todoTableView.insertRows(at: [index], with: .automatic)
            }
        }
        
        let moveToDOING = UIAlertAction(title: "move to DOING", style: .default) { [weak self] _ in
            if tableView.tag == TableViewTag.todo.tag {
                guard let indexPath = self?.todoTableView.indexPath(for: cell),
                      let todoText = self?.todo[safe: indexPath.row] else {
                    return
                }
                
                self?.doing.append(todoText)
                self?.todo.remove(at: indexPath.row)
                self?.todoTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.doing.count else {
                    return
                }
                
                let index = IndexPath(row: count - 1, section: 0)
                self?.doingTableView.insertRows(at: [index], with: .automatic)
            }
            
            if tableView.tag == TableViewTag.done.tag {
                guard let indexPath = self?.doneTableView.indexPath(for: cell),
                      let doneText = self?.done[safe: indexPath.row] else {
                    return
                }
                
                self?.doing.append(doneText)
                self?.done.remove(at: indexPath.row)
                self?.doneTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.doing.count else {
                    return
                }
                
                let index = IndexPath(row: count - 1, section: 0)
                self?.doingTableView.insertRows(at: [index], with: .automatic)
            }
        }
        
        let moveToDONE = UIAlertAction(title: "move to DONE", style: .default) { [weak self] _ in
            if tableView.tag == TableViewTag.todo.tag {
                guard let indexPath = self?.todoTableView.indexPath(for: cell),
                      let todoText = self?.todo[safe: indexPath.row] else {
                    return
                }
                
                self?.done.append(todoText)
                self?.todo.remove(at: indexPath.row)
                self?.todoTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.done.count else {
                    return
                }
                
                let index = IndexPath(row: count - 1, section: 0)
                self?.doneTableView.insertRows(at: [index], with: .automatic)
            }
            
            if tableView.tag == TableViewTag.doing.tag {
                guard let indexPath = self?.doingTableView.indexPath(for: cell),
                      let doingText = self?.doing[safe: indexPath.row] else {
                    return
                }
                
                self?.done.append(doingText)
                self?.doing.remove(at: indexPath.row)
                self?.doingTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.done.count else {
                    return
                }
                
                let index = IndexPath(row: count - 1, section: 0)
                self?.doneTableView.insertRows(at: [index], with: .automatic)
            }
        }
        
        switch tableView.tag {
        case TableViewTag.todo.tag:
            alertController.addAction(moveToDOING)
            alertController.addAction(moveToDONE)
        case TableViewTag.doing.tag:
            alertController.addAction(moveToDo)
            alertController.addAction(moveToDONE)
        case TableViewTag.done.tag:
            alertController.addAction(moveToDo)
            alertController.addAction(moveToDOING)
        default:
            print("error")
        }
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.maxY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alertController, animated: true)
    }
}

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRowCount(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedCell(tableView: tableView, indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction: UIContextualAction = UIContextualAction(style: .destructive, title: "Delete", handler: { [weak self] (action, view, completionHandler) in
            if tableView.tag == TableViewTag.todo.tag {
                self?.todo.remove(at: indexPath.row)
                self?.todoTableView.deleteRows(at: [indexPath], with: .automatic)
            } else if tableView.tag == TableViewTag.doing.tag {
                self?.doing.remove(at: indexPath.row)
                self?.doingTableView.deleteRows(at: [indexPath], with: .automatic)
            } else if tableView.tag == TableViewTag.done.tag {
                self?.done.remove(at: indexPath.row)
                self?.doneTableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                print("error")
            }
            
            completionHandler(true)
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tappedCell(tableView: UITableView, indexPath: IndexPath) {
        var text: ProjectManager?
        let tableViewTag = tableView.tag
        switch tableViewTag {
        case TableViewTag.todo.tag:
            text = todo[safe: indexPath.item]
        case TableViewTag.doing.tag:
            text = doing[safe: indexPath.item]
        case TableViewTag.done.tag:
            text = done[safe: indexPath.item]
        default:
            return
        }
        guard let text = text else {
            return
        }
        
        let TODOViewController: TODOViewController = TODOViewController(writeMode: .edit, text: text, tableViewTag: tableViewTag, indexPath: indexPath)
        TODOViewController.modalPresentationStyle = .formSheet
        TODOViewController.delegate = self
        let navigationController: UINavigationController = UINavigationController(rootViewController: TODOViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func tableViewRowCount(tableView: UITableView) -> Int {
        switch tableView.tag {
        case TableViewTag.todo.tag:
            return todo.count
        case TableViewTag.doing.tag:
            return doing.count
        case TableViewTag.done.tag:
            return done.count
        default:
            return 0
        }
    }
    
    func createCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        var identifier: String
        var data: ProjectManager?
        
        switch tableView.tag {
        case TableViewTag.todo.tag:
            identifier = TableViewTag.todo.description
            data = todo[safe: indexPath.item]
        case TableViewTag.doing.tag:
            identifier = TableViewTag.doing.description
            data = doing[safe: indexPath.item]
        case TableViewTag.done.tag:
            identifier = TableViewTag.done.description
            data = done[safe: indexPath.item]
        default:
            return TableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell,
              let data = data else {
            return TableViewCell()
        }
        
        let longTappedCell = UILongPressGestureRecognizer(target: self, action: #selector(longTappedCell(_:)))
        cell.configureLabel(text: data)
        cell.addGestureRecognizer(longTappedCell)
        
        return cell
    }
}

extension RootViewController: NewTODOViewControllerDelegate {
    func getText(text: ProjectManager, writeMode: WriteMode, tableViewTag: Int, indexPath: IndexPath?) {
        switch writeMode {
        case .new:
            todo.append(text)
            let indexPath = IndexPath(row: todo.count - 1, section: 0)
            todoTableView.insertRows(at: [indexPath], with: .automatic)
        case .edit:
            guard let indexPath = indexPath else {
                return
            }
            
            if tableViewTag == TableViewTag.todo.tag {
                todo[indexPath.row] = text
                todoTableView.reloadRows(at: [indexPath], with: .automatic)
            } else if tableViewTag == TableViewTag.doing.tag {
                doing[indexPath.row] = text
                doingTableView.reloadRows(at: [indexPath], with: .automatic)
            } else if tableViewTag == TableViewTag.done.tag {
                done[indexPath.row] = text
                doneTableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                print("return")
            }
        }
    }
}
