//
//  ProjectManager - ToDoListViewContorller.swift
//  Created by goat.
//  Copyright © goat. All rights reserved.
//

import UIKit

class ToDoListViewContorller: UIViewController, sendToDoListProtocol {
    
    enum TableViewCategory {
        case todoTableView
        case doingTableView
        case doneTableView
    }

    private var toDoList: [ToDoList] = []
    private var doingList: [ToDoList] = []
    private var doneList: [ToDoList] = []
    
    func sendTodoList(data: ToDoList, isCreatMode: Bool) {
        if isCreatMode == true {
            toDoList.append(data)
        } else {
            if let index = toDoList.firstIndex(where: { $0.title == data.title}) {
                toDoList[index] = data
            }
        }
        reloadTableView()
    }
    
    private let toDoStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var toDoTableView = createTableView(title: "TODO")
    lazy var doingTableView = createTableView(title: "DOING")
    lazy var doneTableView = createTableView(title: "DONE")
    
    private func reloadTableView() {
        toDoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
    
    private func createTableView(title: String) -> UITableView {
        let tableview = UITableView()
        tableview.backgroundColor = .systemGray6
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        
        let headerLabel = UILabel(frame: headerView.bounds)
        headerLabel.text = title
        headerLabel.font = .systemFont(ofSize: 32,weight: .medium)
        headerLabel.textAlignment = .natural
        headerView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20)
        ])
        tableview.tableHeaderView = headerView
        
        return tableview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLongPressGesture()
        configureNavigationBar()
        setUpTableView()
        configureViewUI()
    }
    
    // MARK: LongTouchPress, Popover
    private func setUpLongPressGesture() {
        let tableViews: [UITableView] = [toDoTableView, doingTableView, doneTableView]
        for tableView in tableViews {
            let longTouchGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTouchPressed))
            longTouchGesture.minimumPressDuration = 0.3
            tableView.addGestureRecognizer(longTouchGesture)
        }
    }
    
    @objc private func longTouchPressed(_ recognizer: UILongPressGestureRecognizer) {
        guard let selectedTableView = recognizer.view as? UITableView else { return }
        let touchPoint = recognizer.location(in: selectedTableView)
        guard let selectedIndexPathRow = selectedTableView.indexPathForRow(at: touchPoint) else { return }
        
        if recognizer.state == .began {
            switch selectedTableView {
            case toDoTableView:
                showPopover(firstTitle: "MOVE TO DOING",
                            secondTitle: "MOVE TO DONE",
                            firstHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                             firstChoiceTableView: .todoTableView,
                                                                             targetTableView: .doingTableView) },
                            secondHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                              firstChoiceTableView: .todoTableView,
                                                                              targetTableView: .doneTableView) })
            case doingTableView:
                showPopover(firstTitle: "MOVE TO TODO",
                            secondTitle: "MOVE TO DONE",
                            firstHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                             firstChoiceTableView: .doingTableView,
                                                                             targetTableView: .todoTableView)},
                            secondHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                              firstChoiceTableView: .doingTableView,
                                                                              targetTableView: .doneTableView) }
                )
            case doneTableView:
                showPopover(firstTitle: "MOVE TO TODO",
                            secondTitle: "MOVE TO DOING",
                            firstHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                             firstChoiceTableView: .doneTableView,
                                                                             targetTableView: .todoTableView) },
                            secondHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                              firstChoiceTableView: .doneTableView,
                                                                              targetTableView: .doingTableView) }
                )
            default:
                return
            }
        }
    }
    
    private func showPopover(firstTitle: String, secondTitle: String, firstHandler:((UIAlertAction) -> Void)?, secondHandler:((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "이동하고싶은 ", message: "", preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: firstTitle, style: .default, handler: firstHandler)
        let secondeAction = UIAlertAction(title: secondTitle, style: .default, handler: secondHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(firstAction)
        alertController.addAction(secondeAction)
        alertController.addAction(cancelAction)
        
        guard let popoverController = alertController.popoverPresentationController else { return }
        popoverController.sourceView = self.view
        popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        popoverController.permittedArrowDirections = []
        present(alertController, animated: true, completion: nil)
    }
    
    private func convertCellInTableView(indextPath: IndexPath, firstChoiceTableView: TableViewCategory, targetTableView: TableViewCategory) {
        
        switch firstChoiceTableView {
        case .todoTableView:
            let selectedData = toDoList[indextPath.row]
            guard let todoListIndex = toDoList.firstIndex(where: { $0.title == selectedData.title }) else { return }
            let removedItem = toDoList.remove(at: todoListIndex)
            if targetTableView == .doingTableView {
                    doingList.append(removedItem)
            } else if targetTableView == .doneTableView {
                doneList.append(removedItem)
            }
        case .doingTableView:
            let selectedData = doingList[indextPath.row]
            guard let doingListIndex = doingList.firstIndex(where: { $0.title == selectedData.title }) else { return }
            let removedItem = doingList.remove(at: doingListIndex)
            
            if targetTableView == .todoTableView {
                    toDoList.append(removedItem)
            } else if targetTableView == .doneTableView {
                doneList.append(removedItem)
            }
        case .doneTableView:
            let selectedData = doneList[indextPath.row]
            guard let doneListIndex = doneList.firstIndex(where: { $0.title == selectedData.title }) else { return }
            let removedItem = doneList.remove(at: doneListIndex)
            
            if targetTableView == .todoTableView {
                    toDoList.append(removedItem)
            } else if targetTableView == .doingTableView {
                doingList.append(removedItem)
            }
        }
        DispatchQueue.main.async {
            self.reloadTableView()
        }
    }
    
    // MARK: NavigationBar
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc private func plusButtonTapped() {
        let toDoWriteViewController = ToDoWriteViewController(mode: .create)
        toDoWriteViewController.modalPresentationStyle = .formSheet
        
        toDoWriteViewController.delegate = self
        
        self.present(toDoWriteViewController, animated: true)
    }
    
    // MARK: TableView Setting
    private func setUpTableView() {
        toDoTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        doingTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        doneTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        doingTableView.delegate = self
        doingTableView.dataSource = self
        
        doneTableView.delegate = self
        doneTableView.dataSource = self
    }
    
    // MARK: Autolayout
    private func configureViewUI() {
        view.backgroundColor = .white
        view.addSubview(toDoStackView)
        
        toDoStackView.addArrangedSubview(toDoTableView)
        toDoStackView.addArrangedSubview(doingTableView)
        toDoStackView.addArrangedSubview(doneTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        toDoStackView.translatesAutoresizingMaskIntoConstraints = false
        toDoTableView.translatesAutoresizingMaskIntoConstraints = false
        doingTableView.translatesAutoresizingMaskIntoConstraints = false
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toDoStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            toDoStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            toDoStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            toDoStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

extension ToDoListViewContorller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let toDoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell else { return }
        let toDoList = self.toDoList
        
        toDoTableViewCell.setUpLabel(toDoList: toDoList[indexPath.row])
        
        let toDoWriteViewController = ToDoWriteViewController(mode: .edit, fetchedTodoList: toDoList[indexPath.row])
        toDoWriteViewController.modalPresentationStyle = .formSheet
        toDoWriteViewController.delegate = self
        
        self.present(toDoWriteViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete", handler: { action, view, completionHaldler in
            switch tableView {
            case self.toDoTableView:
                self.toDoList.remove(at: indexPath.row)
                self.toDoTableView.deleteRows(at: [indexPath], with: .fade)
            case self.doingTableView:
                self.doingList.remove(at: indexPath.row)
                self.doingTableView.deleteRows(at: [indexPath], with: .fade)
            case self.doneTableView:
                self.doneList.remove(at: indexPath.row)
                self.doneTableView.deleteRows(at: [indexPath], with: .fade)
            default:
                return
            }
            completionHaldler(true)
        })
        
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension ToDoListViewContorller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == toDoTableView {
            return toDoList.count
        } else if tableView == doingTableView {
            return doingList.count
        } else if tableView == doneTableView {
            return doneList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let toDoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        
        if tableView == toDoTableView {
            toDoTableViewCell.setUpLabel(toDoList: toDoList[indexPath.row])
        } else if tableView == doingTableView {
            toDoTableViewCell.setUpLabel(toDoList: doingList[indexPath.row])
        } else if tableView == doneTableView {
            toDoTableViewCell.setUpLabel(toDoList: doneList[indexPath.row])
        }
        return toDoTableViewCell
    }
}
