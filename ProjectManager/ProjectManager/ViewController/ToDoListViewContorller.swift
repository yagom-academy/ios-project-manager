//
//  ProjectManager - ToDoListViewContorller.swift
//  Created by goat.
//  Copyright © goat. All rights reserved.
//

import UIKit

final class ToDoListViewContorller: UIViewController, sendToDoListProtocol {

    private enum TableViewCategory {
        case todoTableView
        case doingTableView
        case doneTableView
    }

    // MARK: tableView, cellCountCircleView
    private var todoCellCount: Int = 0
    private var doingCellCount: Int = 0
    private var doneCellCount: Int = 0
    
    lazy var toDoCircleView = createCellCountCircleView(cellCount: todoCellCount)
    lazy var doingCircleView = createCellCountCircleView(cellCount: doingCellCount)
    lazy var doneCircleView = createCellCountCircleView(cellCount: doneCellCount)
    
    private var toDoList: [ToDoList] = [] {
        didSet {
            todoCellCount = toDoList.count
            updateCircleView(cellCount: todoCellCount, circleView: toDoCircleView)
            reloadTableView()
        }
    }
    private var doingList: [ToDoList] = [] {
        didSet {
            doingCellCount = doingList.count
            updateCircleView(cellCount: doingCellCount, circleView: doingCircleView)
            reloadTableView()
        }
    }
    private var doneList: [ToDoList] = [] {
        didSet {
            doneCellCount = doneList.count
            updateCircleView(cellCount: doneCellCount, circleView: doneCircleView)
            reloadTableView()
        }
    }
    
    lazy var toDoTableView = createTableView(title: "TODO",
                                             cellCount: todoCellCount,
                                             circleView: toDoCircleView)
    lazy var doingTableView = createTableView(title: "DOING",
                                              cellCount: doingCellCount,
                                              circleView: doingCircleView)
    lazy var doneTableView = createTableView(title: "DONE",
                                             cellCount: doneCellCount,
                                             circleView: doneCircleView)
    
    private func createTableView(title: String, cellCount: Int, circleView: UIView) -> UITableView {
        let tableview = UITableView()
        tableview.backgroundColor = .systemGray6
        let headerView = UIView()
        
        let headerLabel = UILabel()
        headerLabel.text = title
        headerLabel.font = .systemFont(ofSize: 32, weight: .medium)
        headerLabel.textAlignment = .natural
        
        let circleView = circleView
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(circleView)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            circleView.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 16),
            circleView.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 32),
            circleView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        headerView.frame = CGRect(x: 0, y: 0, width: tableview.frame.size.width, height: 60)
        tableview.tableHeaderView = headerView
        
        return tableview
    }
    
    private func createCellCountCircleView(cellCount: Int) -> UIView {
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.backgroundColor = .black
        
        let cellCountLabel = UILabel()
        cellCountLabel.text = String(cellCount)
        cellCountLabel.textColor = .white
        cellCountLabel.font = .systemFont(ofSize: 16)
        
        circleView.addSubview(cellCountLabel)
        cellCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellCountLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            cellCountLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor) ])
        
        return circleView
    }
    
    private func updateCircleView(cellCount: Int, circleView: UIView) {
        guard let cellCountLabel = circleView.subviews.compactMap({ $0 as? UILabel }).first else { return }
        
        if cellCount > 99 {
            cellCountLabel.text = "99+"
        } else if cellCount >= 0 {
            cellCountLabel.text = String(cellCount)
        }
    }
    
    private func reloadTableView() {
        toDoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
    
    private let toDoStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        return stackview
    }()
 
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
                showPopover(point: touchPoint, firstTitle: "MOVE TO DOING",
                            secondTitle: "MOVE TO DONE",
                            firstHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                             firstChoiceTableView: .todoTableView,
                                                                             targetTableView: .doingTableView) },
                            secondHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                              firstChoiceTableView: .todoTableView,
                                                                              targetTableView: .doneTableView) })
            case doingTableView:
                showPopover(point: touchPoint, firstTitle: "MOVE TO TODO",
                            secondTitle: "MOVE TO DONE",
                            firstHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                             firstChoiceTableView: .doingTableView,
                                                                             targetTableView: .todoTableView)},
                            secondHandler: { _ in self.convertCellInTableView(indextPath: selectedIndexPathRow,
                                                                              firstChoiceTableView: .doingTableView,
                                                                              targetTableView: .doneTableView) }
                )
            case doneTableView:
                showPopover(point: touchPoint, firstTitle: "MOVE TO TODO",
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
    
    private func showPopover(point: CGPoint, firstTitle: String, secondTitle: String, firstHandler:((UIAlertAction) -> Void)?, secondHandler:((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "이동하고싶은 ", message: "", preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: firstTitle, style: .default, handler: firstHandler)
        let secondeAction = UIAlertAction(title: secondTitle, style: .default, handler: secondHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(firstAction)
        alertController.addAction(secondeAction)
        alertController.addAction(cancelAction)
        
        guard let popoverController = alertController.popoverPresentationController else { return }
        popoverController.sourceView = self.view
        popoverController.sourceRect = CGRect(x: point.x, y: point.y + 70, width: 0, height: 0)
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

// MARK: Delegate - ToDoWriteViewController
extension ToDoListViewContorller {
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
}

// MARK: UITableViewDelegate
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
            tableView.beginUpdates()
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
            tableView.endUpdates()
            completionHaldler(true)
        })
        
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: UITableViewDataSource
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
