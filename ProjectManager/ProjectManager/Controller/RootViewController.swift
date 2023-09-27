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

    
    private let TODOTitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        titleView.configureTitleLabel(text: "TODO")
        
        return titleView
    }()
    
    private let DOINGTitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        titleView.configureTitleLabel(text: "DOING")
        
        return titleView
    }()
    
    private let DONETitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        titleView.configureTitleLabel(text: "DONE")
        
        return titleView
    }()
    
    private let todoTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "todoTableView")
        tableView.tag = TableViewTag.todo.tag
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "doingTableView")
        tableView.tag = TableViewTag.doing.tag
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let doneTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "doneTableView")
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
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        todoTableView.delegate = self
        todoTableView.dataSource = self
        doingTableView.delegate = self
        doingTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.dataSource = self
        view.addSubview(TODOTitleView)
        view.addSubview(DOINGTitleView)
        view.addSubview(DONETitleView)
        view.addSubview(todoTableView)
        view.addSubview(doingTableView)
        view.addSubview(doneTableView)
        
    }
    
    
    func configureNavigation() {
        let plusBotton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(tappedPlusButton))
        navigationItem.rightBarButtonItem = plusBotton
        navigationItem.title = "Project Manager"
        
    }
    
    @objc private func tappedPlusButton() {
        let newTODOViewController: NewTODOViewController = NewTODOViewController(isEditMode: false)
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

    private func configureLayout() {
        let viewWidth = view.safeAreaLayoutGuide.layoutFrame.width / 3.0
        
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: TODOTitleView.bottomAnchor, constant: 8),
            todoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoTableView.widthAnchor.constraint(equalToConstant: viewWidth),
            todoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            doingTableView.topAnchor.constraint(equalTo: DOINGTitleView.bottomAnchor, constant: 8),
            doingTableView.leadingAnchor.constraint(equalTo: todoTableView.trailingAnchor),
            doingTableView.widthAnchor.constraint(equalToConstant: viewWidth),
            doingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            doneTableView.topAnchor.constraint(equalTo: DONETitleView.bottomAnchor, constant: 8),
            doneTableView.leadingAnchor.constraint(equalTo: doingTableView.trailingAnchor),
            doneTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            doneTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            TODOTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            TODOTitleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            TODOTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            TODOTitleView.bottomAnchor.constraint(equalTo: todoTableView.topAnchor),
            
            DOINGTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            DOINGTitleView.leadingAnchor.constraint(equalTo: todoTableView.trailingAnchor),
            DOINGTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            DOINGTitleView.bottomAnchor.constraint(equalTo: doingTableView.topAnchor),
            
            DONETitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            DONETitleView.leadingAnchor.constraint(equalTo: doingTableView.trailingAnchor),
            DONETitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            DONETitleView.bottomAnchor.constraint(equalTo: doneTableView.topAnchor)
            
        ])
    }
}

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == TableViewTag.todo.tag {
            guard let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableView", for: indexPath) as? TableViewCell,
                  let todo = todo[safe: indexPath.item] else {
                return TableViewCell()
            }
            let longTappedCell = UILongPressGestureRecognizer(target: self, action: #selector(longTappedCell(_:)))
            cell.configureLabel(text: todo)
            cell.addGestureRecognizer(longTappedCell)
            
            return cell
        } else if tableView.tag == TableViewTag.doing.tag {
            guard let cell = doingTableView.dequeueReusableCell(withIdentifier: "doingTableView", for: indexPath) as? TableViewCell else {
                return TableViewCell()
            }
            
            guard let doing = doing[safe: indexPath.item] else {
                return TableViewCell()
            }
            
            cell.configureLabel(text: doing)
            
            let longTappedCell = UILongPressGestureRecognizer(target: self, action: #selector(longTappedCell(_:)))
            cell.addGestureRecognizer(longTappedCell)
            
            return cell
        } else if tableView.tag == TableViewTag.done.tag {
            guard let cell = doneTableView.dequeueReusableCell(withIdentifier: "doneTableView", for: indexPath) as? TableViewCell else {
                return TableViewCell()
            }
            
            guard let done = done[safe: indexPath.item] else {
                return TableViewCell()
            }
            
            cell.configureLabel(text: done)
            
            let longTappedCell = UILongPressGestureRecognizer(target: self, action: #selector(longTappedCell(_:)))
            cell.addGestureRecognizer(longTappedCell)
            
            return cell
        }
        return TableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //상세보기
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
}

extension RootViewController: NewTODOViewControllerDelegate {
    func getTextModel(textModel: ProjectManager) {
        self.todo.append(textModel)
        let indexPath = IndexPath(row: todo.count - 1, section: 0)
        todoTableView.insertRows(at: [indexPath], with: .automatic)
    }
}
