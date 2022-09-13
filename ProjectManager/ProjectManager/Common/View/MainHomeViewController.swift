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
    private var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        viewModel.fetchDataList()

        setUpGestureEvent()
        setUpListCount()

        setUpTableViewDelegate()
        setUpTableViewDataSource()

        NotificationCenter.default.addObserver(self, selector: #selector(addModel), name: NSNotification.Name("모델 추가"), object: nil)
    }

    private func setUpGestureEvent() {
        let myGesture = UIPanGestureRecognizer(target: self, action: nil)
        myGesture.delegate = self
        self.todoTableView.addGestureRecognizer(myGesture)

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        longPress.minimumPressDuration = 1
        longPress.delegate = self
        self.todoTableView.addGestureRecognizer(longPress)
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

    private func setUpListCount() {
        todoCount.setTitle(String(viewModel.todoCount), for: .normal)
        doingCount.setTitle(String(viewModel.doingCount), for: .normal)
        doneCount.setTitle(String(viewModel.doneCount), for: .normal)
    }

    private func setUpTableViewDataSource() {
        todoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
    }

    private func setUpTableViewDelegate() {
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
    }

    @objc private func addModel() {
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
}

extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return viewModel.todoCount
        } else if tableView == doingTableView {
            return viewModel.doingCount
        } else {
            return TaskData.shared.databaseManager.getTaskStateCount(state: TaskState.done)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell

        if tableView == todoTableView {
            viewModel.currentState = TaskState.todo
        } else if tableView == doingTableView {
            viewModel.currentState = TaskState.doing
        } else {
            viewModel.currentState = TaskState.done
        }

        let list = viewModel.getDataList()
        let data = list[indexPath.row]

        cell.titleLabel.text = data.taskTitle
        cell.descriptionLabel.text = data.taskDescription
        cell.deadlineLabel.text = data.taskDeadline
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

//            if tableView == self.todoTableView {
//                self.todoList.remove(at: indexPath.row)
//            } else if tableView == self.doingTableView {
//                self.doingList.remove(at: indexPath.row)
//            } else {
//                self.doneList.remove(at: indexPath.row)
//            }
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
