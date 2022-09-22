//
//  ToDoViewController.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import UIKit

final class ToDoViewController: UIViewController, UIGestureRecognizerDelegate, UIPopoverPresentationControllerDelegate {
    enum Schedule {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Schedule, ProjectUnit>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Schedule, ProjectUnit>

    private var toDoViewdataSource: DataSource?
    private var toDoViewSnapshot: Snapshot?

    let viewModel = ToDoViewModel(databaseManager: MockLocalDatabaseManager.shared)

    private let toDoListView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderHeight = 50

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDataSource()
        configureObserver()
        configureTapGesture()
        configureLongPressGesture()
        showAlert()
    }

    @objc private func didTapCell(_ recognizer: UITapGestureRecognizer) {
        guard recognizer.state == UIGestureRecognizer.State.ended else {
            return
        }

        let tapLocation = recognizer.location(in: self.toDoListView)

        guard let tapIndexPath = self.toDoListView.indexPathForRow(at: tapLocation) else {
            return
        }

        presentModalEditView(indexPath: tapIndexPath.row)
    }

    @objc private func didPressCell(_ recognizer: UITapGestureRecognizer) {
        guard recognizer.state == UIGestureRecognizer.State.ended else {
            return
        }

        let longPressLocation = recognizer.location(in: self.toDoListView)

        guard let tapIndexPath = self.toDoListView.indexPathForRow(at: longPressLocation),
              let tappedCell = self.toDoListView.cellForRow(at: tapIndexPath) as? ProjectManagerListCell else {
            return
        }

        configurePopoverController(indexPath: tapIndexPath.row, in: tappedCell)
    }

    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(toDoListView)

        NSLayoutConstraint.activate([
            toDoListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            toDoListView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            toDoListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            toDoListView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureDataSource() {
        toDoListView.register(cellType: ProjectManagerListCell.self)
        toDoListView.delegate = self

        toDoViewdataSource = DataSource(
            tableView: toDoListView,
            cellProvider: { tableView, indexPath, item in
                let cell: ProjectManagerListCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setContents(
                    title: item.title,
                    body: item.body,
                    date: item.deadLine.localizedString
                )

                if self.viewModel.isPassDeadLine(item.deadLine) {
                    cell.changeTextColor()
                }

                cell.separatorInset = .zero

                return cell
            }
        )
    }

    private func configureObserver() {
        viewModel.toDoData.subscribe { [weak self] projectUnitArray in
            guard let self = self else {
                return
            }

            self.toDoViewSnapshot = self.configureSnapshot(data: projectUnitArray)

            guard let toDoViewSnapshot = self.toDoViewSnapshot else {
                return
            }

            self.toDoViewdataSource?.apply(toDoViewSnapshot)
            self.toDoListView.reloadData()
        }
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapCell(_:))
        )
        tapGesture.delegate = self
        toDoListView.addGestureRecognizer(tapGesture)
    }

    private func configureLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(didPressCell(_:))
        )
        longPressGesture.delegate = self
        toDoListView.addGestureRecognizer(longPressGesture)
    }

    private func showAlert() {
        viewModel.showAlert = { [weak self] in
            guard let self = self else {
                return
            }

            let alert = UIAlertController(title: "Error", message: self.viewModel.message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)

            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }

    private func configureSnapshot(data: [ProjectUnit]) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)

        return snapshot
    }

    private func presentModalEditView(indexPath: Int) {
        let projectModificationController = ProjectModificationController()
        projectModificationController.indexPath = indexPath
        projectModificationController.viewModel = self.viewModel
        projectModificationController.title = ProjectStatus.todo

        let navigationController = UINavigationController(rootViewController: projectModificationController)
        navigationController.modalPresentationStyle = .formSheet

        self.present(navigationController, animated: true)
    }

    private func configurePopoverController(indexPath: Int, in cell: UITableViewCell) {
        let controller = PopoverController()
        controller.viewModel = self.viewModel
        controller.indexPath = indexPath
        controller.modalPresentationStyle = UIModalPresentationStyle.popover
        controller.preferredContentSize = CGSize(width: 300, height: 120)
        controller.setTitle(firstButtonName: ProjectStatus.doing, secondButtonName: ProjectStatus.done)

        guard let popController = controller.popoverPresentationController else {
            return
        }
        popController.permittedArrowDirections = .up

        popController.delegate = self
        popController.sourceView = view
        popController.sourceRect = CGRect(
            x: cell.frame.midX,
            y: cell.frame.midY,
            width: 0,
            height: 0
        )

        self.present(controller, animated: true)
    }
}

extension ToDoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        headerView.setupLabelText(section: ProjectStatus.todo, number: viewModel.count)

        return headerView
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .normal,
            title: "Delete"
        ) { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            guard let self = self else {
                return
            }
            self.viewModel.delete(indexPath.row)
            
            success(true)
        }
        delete.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [delete])
    }
}
