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

    @IBOutlet weak var todoCountLabel: UILabel!
    @IBOutlet weak var doingCountLabel: UILabel!
    @IBOutlet weak var doneCountLabel: UILabel!

    private let viewModel = MainHomeViewModel()
    private var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        viewModel.fetchDataList()

        setUpLabelShape()
        setUpTableViewDelegate()
        setUpTableViewDataSource()

        bind()
    }

    private func setUpLabelShape() {
        [todoCountLabel, doingCountLabel, doneCountLabel].forEach {
            $0?.clipsToBounds = true
            $0?.layer.cornerRadius = 20
        }
    }

    private func setUpTableViewDataSource() {
        [todoTableView, doingTableView, doneTableView].forEach {
            $0.dataSource = self
        }
    }

    private func setUpTableViewDelegate() {
        [todoTableView, doingTableView, doneTableView].forEach {
            $0.delegate = self
        }
    }

    private func reloadTableView() {
        [todoTableView, doingTableView, doneTableView].forEach {
            $0.reloadData()
        }
    }

    private func bind() {
        viewModel.todoCount.bind { [weak self] count in
            self?.todoCountLabel.text = count.description
        }

        viewModel.doingCount.bind { [weak self] count in
            self?.doingCountLabel.text = count.description
        }

        viewModel.doneCount.bind { [weak self] count in
            self?.doneCountLabel.text = count.description
        }
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
            return viewModel.todoCount.value
        } else if tableView == doingTableView {
            return viewModel.doingCount.value
        } else {
            return viewModel.doneCount.value
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
            viewModel.currentState = TaskState.todo.name
        } else if tableView == doingTableView {
            viewModel.currentState = TaskState.doing.name
        } else {
            viewModel.currentState = TaskState.done.name
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

            self.viewModel.move(to: TaskState.todo.name, self.selectedIndex)
            self.reloadTableView()
        }
        let doingButton = UIAlertAction(title: "Move to DOING", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.viewModel.move(to: TaskState.doing.name, self.selectedIndex)
            self.reloadTableView()
        }
        let doneButton = UIAlertAction(title: "Move to DONE", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.viewModel.move(to: TaskState.done.name, self.selectedIndex)
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
