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

    @IBAction func didTapAddButton(_ sender: Any) {
        presentTodoForm()
    }

    private let viewModel = MainHomeViewModel()

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
        let todoTap = UITapGestureRecognizer(target: self, action: #selector(didTapTableview))
        todoTap.name = TaskState.todo.name

        let doingTap = UITapGestureRecognizer(target: self, action: #selector(didTapTableview))
        doingTap.name = TaskState.doing.name

        let doneTap = UITapGestureRecognizer(target: self, action: #selector(didTapTableview))
        doneTap.name = TaskState.done.name

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        longPress.minimumPressDuration = 0.5

        [todoTap, doneTap, doneTap, longPress].forEach {
            $0.delegate = self
        }

        todoTableView.addGestureRecognizer(todoTap)
        doingTableView.addGestureRecognizer(doingTap)
        doneTableView.addGestureRecognizer(doneTap)
        view.addGestureRecognizer(longPress)
    }

    @objc func didTapTableview(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: recognizer.view)
        viewModel.selectedInfo.state = getTaskState(state: recognizer.name ?? "")

        if recognizer.name == TaskState.todo.name {
            viewModel.selectedInfo.index = todoTableView.indexPathForRow(at: location)?.row ?? 0
        } else if recognizer.name == TaskState.doing.name {
            viewModel.selectedInfo.index = doingTableView.indexPathForRow(at: location)?.row ?? 0
        } else {
            viewModel.selectedInfo.index = doneTableView.indexPathForRow(at: location)?.row ?? 0
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

        reloadTableView()
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

extension MainHomeViewController: SendDelegate, ReuseIdentifying {
    func sendData<T>(_ data: T) {
        guard let data = data as? TaskModel else {
            return
        }

        viewModel.changeList(data: data)
        bind()
    }
}

extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.fetchDataList()

        if tableView === todoTableView {
            return viewModel.todoCount.value
        } else if tableView === doingTableView {
            return viewModel.doingCount.value
        } else {
            return viewModel.doneCount.value
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
        cell.setUpCell(data: list[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = setUpTaskState(tableView: tableView)
        let data = viewModel.readData(index: indexPath.row, in: state)
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

    func getTaskState(state: String) -> TaskState {
        let taskState = TaskState.allCases.filter {
            $0.name == state
        }

        return taskState.first ?? TaskState.todo
    }
}

extension MainHomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }

    @objc func handleLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: recognizer.view)
        let actionButtons = getActionButton(
            of: viewModel.selectedInfo.state,
            viewModel.selectedInfo.index
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
        popover?.sourceRect = CGRect(x: location.x, y: location.y, width: 0, height: 0)

        present(actionSheet, animated: true)
    }
}
