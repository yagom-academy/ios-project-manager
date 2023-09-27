//
//  ProjectManager - RootViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class RootViewController: UIViewController {
    private var TODO: [TextModel] = []
    private var DOING: [TextModel] = []
    private var DONE: [TextModel] = []
    private var index: IndexPath?
    
    private let TODOTitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        titleView.titleLabel.text = "TODO"
        
        return titleView
    }()
    
    private let DOINGTitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        titleView.titleLabel.text = "DOING"
        
        return titleView
    }()
    
    private let DONETitleView: UIView = {
        let titleView: TitleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .red
        titleView.titleLabel.text = "DONE"
        
        return titleView
    }()
    
    private let leftTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "leftTableView")
        tableView.tag = 1
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let centerTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "centerTableView")
        tableView.tag = 2
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let rightTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "rightTableView")
        tableView.tag = 3
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
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(true)
    //        getTextModel(
    //    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        leftTableView.delegate = self
        leftTableView.dataSource = self
        centerTableView.delegate = self
        centerTableView.dataSource = self
        rightTableView.delegate = self
        rightTableView.dataSource = self
        view.addSubview(TODOTitleView)
        view.addSubview(DOINGTitleView)
        view.addSubview(DONETitleView)
        view.addSubview(leftTableView)
        view.addSubview(centerTableView)
        view.addSubview(rightTableView)
        
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
        print("셀이 길게눌림")
        
        guard let cell = gestureRecognizer.view as? UITableViewCell else {
            return
        }
        
        guard let tableView = cell.superview as? UITableView else {
            return
        }
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let moveToDOING = UIAlertAction(title: "move to DOING", style: .default) { [weak self] _ in
            
            
            if tableView.tag == 1 {
                
                guard let indexPath = self?.leftTableView.indexPath(for: cell) else {
                    return
                }
                guard let todoTextModel = self?.TODO[safe: indexPath.row] else {
                    return
                }
                self?.DOING.append(todoTextModel)
                self?.TODO.remove(at: indexPath.row)
                self?.leftTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.DOING.count else {
                    return
                }
                
                
                let index = IndexPath(row: count - 1, section: 0)
                self?.centerTableView.insertRows(at: [index], with: .automatic)
                
                
            }
            if tableView.tag == 3 {
                guard let indexPath = self?.rightTableView.indexPath(for: cell) else {
                    return
                }
                guard let doingTextModel = self?.DOING[safe: indexPath.row] else {
                    return
                }
                self?.DONE.append(doingTextModel)
                self?.DOING.remove(at: indexPath.row)
                self?.centerTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.DONE.count else {
                    return
                }
                let index = IndexPath(row: count - 1, section: 0)
                self?.rightTableView.insertRows(at: [index], with: .automatic)
            }
        }
        
        let moveToDONE = UIAlertAction(title: "move to DONE", style: .default) { [weak self] _ in
            if tableView.tag == 1 {
                
                guard let indexPath = self?.leftTableView.indexPath(for: cell) else {
                    return
                }
                guard let todoTextModel = self?.TODO[safe: indexPath.row] else {
                    return
                }
                self?.DONE.append(todoTextModel)
                self?.TODO.remove(at: indexPath.row)
                self?.leftTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.DONE.count else {
                    return
                }
                
                
                let index = IndexPath(row: count - 1, section: 0)
                self?.rightTableView.insertRows(at: [index], with: .automatic)
            }
            if tableView.tag == 2 {
                guard let indexPath = self?.centerTableView.indexPath(for: cell) else {
                    return
                }
                guard let doingTextModel = self?.DOING[safe: indexPath.row] else {
                    return 
                }
                self?.DONE.append(doingTextModel)
                self?.DOING.remove(at: indexPath.row)
                self?.centerTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.DONE.count else {
                    return
                }
                let index = IndexPath(row: count - 1, section: 0)
                self?.rightTableView.insertRows(at: [index], with: .automatic)
            }
        }
        
        let moveToDo = UIAlertAction(title: "move to TODO", style: .default) { [weak self] _ in
            if tableView.tag == 2 {
                guard let indexPath = self?.centerTableView.indexPath(for: cell) else {
                    return
                }
                guard let doingTextModel = self?.DOING[safe: indexPath.row] else {
                    return
                }
                self?.TODO.append(doingTextModel)
                self?.DOING.remove(at: indexPath.row)
                self?.centerTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.TODO.count else {
                    return
                }
                let index = IndexPath(row: count - 1, section: 0)
                self?.leftTableView.insertRows(at: [index], with: .automatic)
            }
            
            if tableView.tag == 3 {
                guard let indexPath = self?.rightTableView.indexPath(for: cell) else {
                    return
                }
                guard let doneTextModel = self?.DONE[safe: indexPath.row] else {
                    return
                }
                self?.TODO.append(doneTextModel)
                self?.DONE.remove(at: indexPath.row)
                self?.rightTableView.deleteRows(at: [indexPath], with: .automatic)
                
                guard let count = self?.TODO.count else {
                    return
                }
                let index = IndexPath(row: count - 1, section: 0)
                self?.leftTableView.insertRows(at: [index], with: .automatic)
            }
            
        }
        if tableView.tag == 1 {
            alertController.addAction(moveToDOING)
            alertController.addAction(moveToDONE)
        }
        if tableView.tag == 2 {
            alertController.addAction(moveToDo)
            alertController.addAction(moveToDONE)
        }
        if tableView.tag == 3 {
            alertController.addAction(moveToDo)
            alertController.addAction(moveToDOING)
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
            leftTableView.topAnchor.constraint(equalTo: TODOTitleView.bottomAnchor, constant: 8),
            leftTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            leftTableView.widthAnchor.constraint(equalToConstant: viewWidth),
            leftTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            centerTableView.topAnchor.constraint(equalTo: DOINGTitleView.bottomAnchor, constant: 8),
            centerTableView.leadingAnchor.constraint(equalTo: leftTableView.trailingAnchor),
            centerTableView.widthAnchor.constraint(equalToConstant: viewWidth),
            centerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            rightTableView.topAnchor.constraint(equalTo: DONETitleView.bottomAnchor, constant: 8),
            rightTableView.leadingAnchor.constraint(equalTo: centerTableView.trailingAnchor),
            rightTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rightTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            TODOTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            TODOTitleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            TODOTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            TODOTitleView.bottomAnchor.constraint(equalTo: leftTableView.topAnchor),
            
            DOINGTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            DOINGTitleView.leadingAnchor.constraint(equalTo: leftTableView.trailingAnchor),
            DOINGTitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            DOINGTitleView.bottomAnchor.constraint(equalTo: centerTableView.topAnchor),
            
            DONETitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            DONETitleView.leadingAnchor.constraint(equalTo: centerTableView.trailingAnchor),
            DONETitleView.widthAnchor.constraint(equalToConstant: viewWidth),
            DONETitleView.bottomAnchor.constraint(equalTo: rightTableView.topAnchor)
            
        ])
    }
}

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return TODO.count
        } else if tableView.tag == 2 {
            return DOING.count
        } else if tableView.tag == 3 {
            return DONE.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            guard let cell = leftTableView.dequeueReusableCell(withIdentifier: "leftTableView", for: indexPath) as? TableViewCell else {
                return TableViewCell()
            }
            
            guard let todo = TODO[safe: indexPath.item] else {
                return TableViewCell()
            }
            
            cell.configureLabel(textModel: todo)
            
            let longTappedCell = UILongPressGestureRecognizer(target: self, action: #selector(longTappedCell(_:)))
            cell.addGestureRecognizer(longTappedCell)
            
            return cell
        } else if tableView.tag == 2 {
            guard let cell = centerTableView.dequeueReusableCell(withIdentifier: "centerTableView", for: indexPath) as? TableViewCell else {
                return TableViewCell()
            }
            
            guard let doing = DOING[safe: indexPath.item] else {
                return TableViewCell()
            }
            
            cell.configureLabel(textModel: doing)
            
            let longTappedCell = UILongPressGestureRecognizer(target: self, action: #selector(longTappedCell(_:)))
            cell.addGestureRecognizer(longTappedCell)
            
            return cell
        } else if tableView.tag == 3 {
            guard let cell = rightTableView.dequeueReusableCell(withIdentifier: "rightTableView", for: indexPath) as? TableViewCell else {
                return TableViewCell()
            }
            
            guard let done = DONE[safe: indexPath.item] else {
                return TableViewCell()
            }
            
            cell.configureLabel(textModel: done)
            
            let longTappedCell = UILongPressGestureRecognizer(target: self, action: #selector(longTappedCell(_:)))
            cell.addGestureRecognizer(longTappedCell)
            
            return cell
        }
        return TableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction: UIContextualAction = UIContextualAction(style: .destructive, title: "Delete", handler: { [weak self] (action, view, completionHandler) in
            print("deleteAction")
            //변수가져다 쓰면 weak self 추가하기
            if tableView.tag == 1 {
                self?.TODO.remove(at: indexPath.row)
                self?.leftTableView.deleteRows(at: [indexPath], with: .automatic)
            } else if tableView.tag == 2 {
                self?.DOING.remove(at: indexPath.row)
                self?.centerTableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                self?.DONE.remove(at: indexPath.row)
                self?.rightTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            completionHandler(true)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}

extension RootViewController: NewTODOViewControllerDelegate {
    func getTextModel(textModel: TextModel) {
        self.TODO.append(textModel)
        
        let indexPath = IndexPath(row: TODO.count - 1, section: 0)
        leftTableView.insertRows(at: [indexPath], with: .automatic)
        
    }
}
