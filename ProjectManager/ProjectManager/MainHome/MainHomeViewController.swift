//
//  ProjectManager - MainHomeViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainHomeViewController: UIViewController {
    // MARK: Properties
    private let viewModel = MainHomeViewModel()

    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!

    @IBOutlet weak var todoCountLabel: UILabel!
    @IBOutlet weak var doingCountLabel: UILabel!
    @IBOutlet weak var doneCountLabel: UILabel!

    // MARK: IBAction
    @IBAction func didTapAddButton(_ sender: Any) {
        presentTodoForm()
    }

    //private var realmManager = RealmManager.shared

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        viewModel.fetchDataList()

        setUpLabelShape()
        setUpTableViewDelegate()
        setUpTableViewDataSource()
        setUpGestureEvent()

        bind()

        //realmManager.initialize()
    }

    // MARK: Method
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

    private func setUpGestureEvent() {
        let todoLongPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        todoLongPress.name = TaskState.todo.name

        let doingLongPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        doingLongPress.name = TaskState.doing.name

        let doneLongPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        doneLongPress.name = TaskState.done.name

        [todoLongPress, doingLongPress, doneLongPress].forEach {
            $0.minimumPressDuration = 0.5
        }

        todoTableView.addGestureRecognizer(todoLongPress)
        doingTableView.addGestureRecognizer(doingLongPress)
        doneTableView.addGestureRecognizer(doneLongPress)
    }

    private func bind() {
        viewModel.change = { [weak self] in
            self?.todoCountLabel.text = self?.viewModel.todoCount.description
            self?.doingCountLabel.text = self?.viewModel.doingCount.description
            self?.doneCountLabel.text = self?.viewModel.doneCount.description
        }
    }

    private func reloadTableView() {
        [todoTableView, doingTableView, doneTableView].forEach {
            $0.reloadData()
        }
    }

    private func presentTodoForm(with data: TaskModel? = nil) {
        guard let storyboard = storyboard,
              let todoFormViewController = storyboard.instantiateViewController(
                withIdentifier: TodoFormViewController.reuseIdentifier
              ) as? TodoFormViewController else {
            return
        }

        if data != nil {
            todoFormViewController.sendData(data)
        }

        todoFormViewController.delegate = self
        present(todoFormViewController, animated: true)
    }
}

// MARK: extension - SendDelegate
extension MainHomeViewController: SendDelegate, ReuseIdentifying {
    func sendData<T>(_ data: T) {
        guard let data = data as? TaskModel else {
            return
        }

        viewModel.changeList(data: data)
        reloadTableView()
    }
}

// MARK: extension - UITableViewDelegate
extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.fetchDataList()

        if tableView === todoTableView {
            return viewModel.todoCount
        } else if tableView === doingTableView {
            return viewModel.doingCount
        } else {
            return viewModel.doneCount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = todoTableView.dequeueReusableCell(
            withIdentifier: TableViewCell.reuseIdentifier,
            for: indexPath
        ) as? TableViewCell else {
            return UITableViewCell()
        }

        let state = setUpTaskState(tableView: tableView)
        let list = viewModel.getDataList(of: state)
        var data = list[indexPath.row]
        data.deadLineLabelTextColor = data.checkPastDate()
        cell.setUpCell(data: data)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = setUpTaskState(tableView: tableView)
        let data = viewModel.getDataList(of: state)[indexPath.row]

        presentTodoForm(with: data)

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

            let state = self.setUpTaskState(tableView: tableView)
            self.viewModel.remove(index: indexPath.row, in: state)
            self.reloadTableView()
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func setUpTaskState(tableView: UITableView) -> TaskState {
        if tableView == todoTableView {
            return TaskState.todo
        } else if tableView == doingTableView {
            return TaskState.doing
        } else {
            return TaskState.done
        }
    }
}

// MARK: extension - UIGestureRecognizer Method
extension MainHomeViewController {
    @objc func handleLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        let cellInfo = getCellInfo(recognizer: recognizer)
        let actionButtons = getActionButton(
            of: cellInfo.state,
            cellInfo.index
        )
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        guard let first = actionButtons.first,
              let second = actionButtons.last else {
            return
        }

        actionSheet.addAction(first)
        actionSheet.addAction(second)

        let popover = actionSheet.popoverPresentationController
        popover?.sourceView = view
        popover?.sourceRect = CGRect(
            x: recognizer.view?.frame.midX ?? 0 ,
            y: recognizer.location(in: recognizer.view).y + 140,
            width: 0,
            height: 0
        )

        present(actionSheet, animated: true)
    }

    private func getCellInfo(recognizer: UILongPressGestureRecognizer) -> (state: TaskState, index: Int) {
        let location = recognizer.location(in: recognizer.view)
        let state = getTaskState(state: recognizer.name ?? "")
        var index = 0

        if recognizer.name == TaskState.todo.name {
            index = todoTableView.indexPathForRow(at: location)?.row ?? 0
        } else if recognizer.name == TaskState.doing.name {
            index = doingTableView.indexPathForRow(at: location)?.row ?? 0
        } else {
            index = doneTableView.indexPathForRow(at: location)?.row ?? 0
        }

        return (state,index)
    }

    private func getTaskState(state: String) -> TaskState {
        let taskState = TaskState.allCases.filter {
            $0.name == state
        }

        return taskState.first ?? TaskState.todo
    }

    private func getActionButton(of taskState: TaskState, _ index: Int) -> [UIAlertAction] {
        let firstButton = UIAlertAction(
            title: taskState.title.first,
            style: .default) { [weak self] _ in
                guard let self = self else {
                    return
                }

                self.viewModel.move(
                    index,
                    from:taskState,
                    to: taskState.other.first ?? taskState
                )

                self.reloadTableView()
            }
        let secondButton = UIAlertAction(
            title: taskState.title.last,
            style: .default
        ) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.viewModel.move(
                index,
                from:taskState,
                to: taskState.other.last ?? taskState
            )

            self.reloadTableView()
        }

        return [firstButton, secondButton]
    }
}
