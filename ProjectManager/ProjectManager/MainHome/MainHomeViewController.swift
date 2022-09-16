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

        setUpTableViewCount()
        setUpTableViewDelegate()
        setUpTableViewDataSource()
    }

    private func setUpTableViewCount() {
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

    private func reloadTableView() {
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()

        setUpTableViewCount()
    }
}

extension MainHomeViewController: SendDelegate, ReuseIdentifying {
    func sendData<T>(_ data: T) {
        guard let data = data as? TaskModel else {
            return
        }

        viewModel.changeList(data: data)
    }
}

extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return viewModel.todoCount
        } else if tableView == doingTableView {
            return viewModel.doingCount
        } else {
            return viewModel.doneCount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell

        setUpTaskState(tableView: tableView)

        let list = viewModel.getDataList()
        let data = list[indexPath.row]

        cell.setUpCell(data: data)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        setUpTaskState(tableView: tableView)
        setUpGestureEvent(tableView)

        guard let storyboard = storyboard,
              let todoFormViewController = storyboard.instantiateViewController(
                withIdentifier: TodoFormViewController.reuseIdentifier
              ) as? TodoFormViewController else {
            return
        }

        weak var sendDelegate: (SendDelegate)? = todoFormViewController
        sendDelegate?.sendData(viewModel.readData(index: indexPath.row))
        present(todoFormViewController, animated: true)

        tableView.deselectRow(at: indexPath, animated: false)
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

            self.setUpTaskState(tableView: tableView)
            self.viewModel.remove(index: indexPath.row)
            self.reloadTableView()
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func setUpTaskState(tableView: UITableView) {
        if tableView == todoTableView {
            viewModel.currentState = TaskState.todo
        } else if tableView == doingTableView {
            viewModel.currentState = TaskState.doing
        } else {
            viewModel.currentState = TaskState.done
        }
    }
}

extension MainHomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }

    private func setUpGestureEvent(_ tableView: UITableView) {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        longPress.minimumPressDuration = 0.5
        longPress.delegate = self
        tableView.addGestureRecognizer(longPress)
    }

    @objc func handleLongPressGesture(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: recognizer.view)
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let todoButton = UIAlertAction(title: "Move to TODO", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.viewModel.move(to: TaskState.todo, self.selectedIndex)
            self.reloadTableView()
        }
        let doingButton = UIAlertAction(title: "Move to DOING", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.viewModel.move(to: TaskState.doing, self.selectedIndex)
            self.reloadTableView()
        }
        let doneButton = UIAlertAction(title: "Move to DONE", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.viewModel.move(to: TaskState.done, self.selectedIndex)
            self.reloadTableView()
        }
        actionSheet.addAction(todoButton)
        actionSheet.addAction(doingButton)
        actionSheet.addAction(doneButton)

        let popover = actionSheet.popoverPresentationController
        popover?.sourceView = view
        popover?.sourceRect = CGRect(x: location.x, y: location.y + 120 , width: 60, height: 60)

        present(actionSheet, animated: true)
    }
}
