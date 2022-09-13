//
//  ProjectManager - MainHomeViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainHomeViewController: UIViewController {

    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!

    @IBOutlet weak var todoCount: UIButton!
    @IBOutlet weak var doingCount: UIButton!
    @IBOutlet weak var doneCount: UIButton!

    private let viewModel = MainHomeViewModel()

    private var todoList = [TaskModel]()
    private var doingList = [TaskModel]()
    private var doneList = [TaskModel]()
    private var selectedCell: TaskModel?
    private var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        setUpDataList()

        let myGesture = UIPanGestureRecognizer(target: self, action: nil)
        myGesture.delegate = self
        self.todoTableView.addGestureRecognizer(myGesture)

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        longPress.minimumPressDuration = 1
        longPress.delegate = self
        self.todoTableView.addGestureRecognizer(longPress)

        todoCount.setTitle(String(viewModel.todoCount), for: .normal)
        doingCount.setTitle(String(viewModel.doingCount), for: .normal)
        doneCount.setTitle(String(viewModel.doneCount), for: .normal)

        todoTableView.dataSource = self
        todoTableView.delegate = self

        doingTableView.dataSource = self
        doingTableView.delegate = self

        doneTableView.dataSource = self
        doneTableView.delegate = self
    }

    @objc func handleLongPressGesture(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: recognizer.view)
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let doingButton = UIAlertAction(title: "Move to DOING", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.viewModel.move(to: TaskState.doing, self.selectedIndex)
        }
        let doneButton = UIAlertAction(title: "Move to DONE", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.viewModel.move(to: TaskState.done, self.selectedIndex)
        }
        actionSheet.addAction(doingButton)
        actionSheet.addAction(doneButton)

        let popover = actionSheet.popoverPresentationController
        popover?.sourceView = view
        popover?.sourceRect = CGRect(x: location.x, y: location.y + 60 , width: 60, height: 60)

        present(actionSheet, animated: true)
    }

    private func setUpDataList() {
        let allDatabase = TaskData.shared.databaseManager.readDatabase()

        allDatabase.forEach { task in
            if task.taskState == TaskState.todo {
                todoList.append(task)
            } else if task.taskState == TaskState.doing {
                doingList.append(task)
            } else {
                doneList.append(task)
            }
        }
    }
}

extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return TaskData.shared.databaseManager.getTaskStateCount(state: TaskState.todo)
        } else if tableView == doingTableView {
            return TaskData.shared.databaseManager.getTaskStateCount(state: TaskState.doing)
        } else {
            return TaskData.shared.databaseManager.getTaskStateCount(state: TaskState.done)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == todoTableView {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            let data = todoList[indexPath.row]
            cell.titleLabel.text = data.taskTitle
            cell.descriptionLabel.text = data.taskDescription
            cell.deadlineLabel.text = data.taskDeadline
            return cell
        } else if tableView == doingTableView {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            let data = doingList[indexPath.row]
            cell.titleLabel.text = data.taskTitle
            cell.descriptionLabel.text = data.taskDescription
            cell.deadlineLabel.text = data.taskDeadline
            return cell
        } else {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            let data = doneList[indexPath.row]
            cell.titleLabel.text = data.taskTitle
            cell.descriptionLabel.text = data.taskDescription
            cell.deadlineLabel.text = data.taskDeadline
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == todoTableView {
            selectedCell = todoList[indexPath.row]
        } else if tableView == doingTableView {
            selectedCell = doingList[indexPath.row]
        } else {
            selectedCell = doneList[indexPath.row]
        }

        selectedIndex = indexPath.row
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] _,_,_  in
            guard let self = self else {
                return
            }

            if tableView == self.todoTableView {
                self.todoList.remove(at: indexPath.row)
            } else if tableView == self.doingTableView {
                self.doingList.remove(at: indexPath.row)
            } else {
                self.doneList.remove(at: indexPath.row)
            }
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension MainHomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
}
