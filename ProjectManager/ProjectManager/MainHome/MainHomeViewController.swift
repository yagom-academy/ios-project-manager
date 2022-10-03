//
//  ProjectManager - MainHomeViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainHomeViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    // MARK: Properties
    private let viewModel = MainHomeViewModel()
    private var historyViewController: HistoryViewController?

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

    @IBAction func didTapHistoryButton(_ sender: Any) {
        guard let historyViewController = historyViewController else {
            return
        }

        historyViewController.modalPresentationStyle = .popover
        let popover = historyViewController.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = self.view
        popover?.sourceRect = CGRect(x: 70, y: 70, width: 0, height: 0)
        present(historyViewController, animated: true)
    }

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fixScreenOrientation()
        addObservers()

        setUpLabelShape()
        setUpTableViewDelegate()
        setUpTableViewDataSource()
        setUpGestureEvent()
        setUpHistoryViewController()

        bind()

        viewModel.synchronize()
    }

    // MARK: Method
    private func fixScreenOrientation() {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showAlert),
            name: NSNotification.Name("disconnect"),
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadTableView),
            name: NSNotification.Name("changeTableView"),
            object: nil
        )
    }

    @objc private func showAlert() {
        let alertController = UIAlertController(
            title: "네트워크에 접속할 수 없습니다.",
            message: "네트워크 연결 상태를 확인해주세요.",
            preferredStyle: .alert
        )

        let confirmAction = UIAlertAction(title: "확인", style: .default)

        alertController.addAction(confirmAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
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

    private func setUpHistoryViewController() {
        guard let storyboard = storyboard,
              let historyVC = storyboard.instantiateViewController(
                withIdentifier: HistoryViewController.reuseIdentifier
              ) as? HistoryViewController else {
            return
        }

        self.historyViewController = historyVC
    }

    private func bind() {
        viewModel.change = { [weak self] in
            self?.todoCountLabel.text = self?.viewModel.todoCount.description
            self?.doingCountLabel.text = self?.viewModel.doingCount.description
            self?.doneCountLabel.text = self?.viewModel.doneCount.description
        }
    }

    @objc private func reloadTableView() {
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

        let activity = viewModel.changeList(data: data)

        guard let activity = activity else {
            return
        }

        let sendData = SendModel(
            activity: activity,
            title: data.taskTitle,
            from: data.taskState,
            date: Date()
        )
        self.historyViewController?.sendData(sendData)
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
            withIdentifier: TaskTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? TaskTableViewCell else {
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
            let removedData = self.viewModel.getDataList(of: state)[indexPath.row]
            self.viewModel.remove(index: indexPath.row, in: state)

            let sendData = SendModel(
                activity: Activity.removed,
                title: removedData.taskTitle,
                from: state.name,
                date: Date()
            )
            self.historyViewController?.sendData(sendData)
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
        let data = viewModel.getDataList(of: taskState)[index]
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

                let sendData = SendModel(
                    activity: Activity.moved,
                    title: data.taskTitle,
                    from: taskState.name,
                    to: taskState.other.first?.name,
                    date: Date()
                )
                self.historyViewController?.sendData(sendData)
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

            let sendData = SendModel(
                activity: Activity.moved,
                title: data.taskTitle,
                from: taskState.name,
                to: taskState.other.last?.name,
                date: Date()
            )
            self.historyViewController?.sendData(sendData)
        }

        return [firstButton, secondButton]
    }
}
