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

    let viewModel = ToDoViewModel(databaseManager: MockLocalDatabaseManager())

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
        configureLongPressGesture()
    }

    private func configureLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(didPressCell(_:))
        )
        longPressGesture.delegate = self
        toDoListView.addGestureRecognizer(longPressGesture)
    }

    @objc func didPressCell(_ recognizer: UITapGestureRecognizer) {
        guard recognizer.state == UIGestureRecognizer.State.began else {
            return
        }

        let longPressLocation = recognizer.location(in: self.toDoListView)

        guard let tapIndexPath = self.toDoListView.indexPathForRow(at: longPressLocation),
              let tappedCell = self.toDoListView.cellForRow(at: tapIndexPath) as? ProjectManagerListCell else {
            return
        }

        configurePopoverController(in: tappedCell)
    }

    private func configurePopoverController(in cell: UITableViewCell) {
        let controller = PopoverController()
        controller.modalPresentationStyle = UIModalPresentationStyle.popover
        controller.preferredContentSize = CGSize(width: 300, height: 120)
        controller.setTitle(firstButtonName: "DOING", secondButtonName: "DONE")

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

    private func configureSnapshot(data: [ProjectUnit]) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)

        return snapshot
    }
}

extension ToDoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        headerView.setupLabelText(section: "TODO", number: viewModel.count)

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
