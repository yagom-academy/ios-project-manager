//
//  TableViewController.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class TableViewController: UIViewController {
    private let todoViewModel = TableViewModel(tableViewType: .todo)
    private let doingViewModel = TableViewModel(tableViewType: .doing)
    private let doneViewModel = TableViewModel(tableViewType: .done)
    private var selectIndexPath: IndexPath?
    private var isTablesNotSame: Bool?
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    @IBOutlet weak var todoTableRowCount: UILabel!
    @IBOutlet weak var doingTableRowCount: UILabel!
    @IBOutlet weak var doneTableRowCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewDelegate(todoTableView)
        setTableViewDelegate(doingTableView)
        setTableViewDelegate(doneTableView)
        setTablesRowCount()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailViewNotification(_:)),
            name: Notification.Name(Strings.didDismissDetailViewNotification),
            object: nil
        )
        
        todoViewModel.memoList.bind { _ in
            DispatchQueue.main.async {
                self.updateTable()
            }
        }
        
        fetchData()
    }
    
    @objc private func didDismissDetailViewNotification(_ notification: Notification) {
        fetchData()
    }
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        if segue.identifier == Strings.showDetailViewSegueIdentifier {
            let viewController = segue.destination as? DetailViewController
            
            if let cellInfo = sender as? CellInfo {
                viewController?.changeToEditMode()
                // TODO: - Step2 진행시 server side를 고려하여 변경해야 할 점
                // 전달하는 정보를 index에서 id로 변경
                // tableViewModel째로 넘기는건 무모함 -> 해당하는 아이템만 넘기자
                // 그러면서 tableViewType정보도 넘겨야 함
                viewController?.setViewModel(cellInfo: cellInfo)
            }
        }
    }
    
    @IBAction func clickPlusButton(_ sender: Any) {
        performSegue(
            withIdentifier: Strings.addTodoListItemSegueIdentifier,
            sender: nil
        )
    }
    
    func updateTable() {
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
        
        updateAllTableRowCount()
    }
    
    private func viewModel(of tableView: UITableView) -> TableViewModel {
        if tableView == todoTableView {
            return todoViewModel
        } else if tableView == doingTableView {
            return doingViewModel
        } else {
            return doneViewModel
        }
    }
    
    private func fetchData() {
//        DispatchQueue.global().async {
            self.todoViewModel.fetchData()
            self.doingViewModel.fetchData()
            self.doneViewModel.fetchData()
//        }
    }
}

// MARK: - View Setting
extension TableViewController {
    private func updateAllTableRowCount() {
        // TODO: - 값을 metadata.total로 바꾸자
        // 여기에 data binding도 구현해야 함..
        todoTableRowCount.text = "\(todoViewModel.numOfList)"
        doingTableRowCount.text = "\(doingViewModel.numOfList)"
        doneTableRowCount.text = "\(doneViewModel.numOfList)"
    }
    
    private func setTableViewDelegate(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    private func setTablesRowCount() {
        // TODO: - UILabel의 SubClass를 만들어서 처리
        let circleImage = UIImage(systemName: Strings.circleImageName)
        todoTableRowCount.backgroundColor = UIColor(patternImage: circleImage!)
        doingTableRowCount.backgroundColor = UIColor(patternImage: circleImage!)
        doneTableRowCount.backgroundColor = UIColor(patternImage: circleImage!)
        
        updateAllTableRowCount()
    }
}

// MARK: - UITableViewDelegate
extension TableViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let viewModel = viewModel(of: tableView)
        let itemInfo = viewModel.itemInfo(at: indexPath.row)
        let cellInfo = CellInfo(
            tableViewType: viewModel.tableViewType,
            itemInfo: itemInfo
        )
        performSegue(
            withIdentifier: Strings.showDetailViewSegueIdentifier,
            sender: cellInfo
        )
    }
}

// MARK: - UITableViewDataSource
extension TableViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let viewModel = viewModel(of: tableView)
        return viewModel.numOfList
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let viewModel = viewModel(of: tableView)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.identifier,
            for: indexPath
        ) as! TableViewCell
        cell.update(info: viewModel.memoInfo(at: indexPath.row)!)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        canEditRowAt indexPath: IndexPath
    ) -> Bool {
        return true
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        let viewModel = viewModel(of: tableView)
        if editingStyle == .delete {
            viewModel.removeCell(at: indexPath.row)
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        let viewModel = viewModel(of: tableView)
        let moveCell = viewModel.itemInfo(at: sourceIndexPath.row)
        viewModel.removeCell(at: sourceIndexPath.row)
        viewModel.insert(
            cell: moveCell,
            at: destinationIndexPath.row
        )
    }
}

// MARK: - UITableViewDragDelegate
extension TableViewController: UITableViewDragDelegate {
    func tableView(
        _ tableView: UITableView,
        itemsForBeginning session: UIDragSession,
        at indexPath: IndexPath
    ) -> [UIDragItem] {
        let viewModel = viewModel(of: tableView)
        let tableItem = viewModel.itemInfo(at: indexPath.row)
        let itemProvider = NSItemProvider(object: tableItem)
        selectIndexPath = indexPath
        isTablesNotSame = false
        
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func tableView(
        _ tableView: UITableView,
        dragSessionDidEnd session: UIDragSession
    ) {
        guard let selectIndexPath = selectIndexPath,
              let isTablesNotSame = isTablesNotSame
        else {
            return
        }
        if isTablesNotSame {
            let viewModel = viewModel(of: tableView)
            viewModel.removeCell(at: selectIndexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(
                at: [selectIndexPath],
                with: .automatic
            )
            tableView.endUpdates()
            updateAllTableRowCount()
        }
    }
}

// MARK: - UITableViewDropDelegate
extension TableViewController: UITableViewDropDelegate {
    func tableView(
        _ tableView: UITableView,
        canHandle session: UIDropSession
    ) -> Bool {
        return session.canLoadObjects(ofClass: Memo.self)
    }
    
    func tableView(
        _ tableView: UITableView,
        dropSessionDidUpdate session: UIDropSession,
        withDestinationIndexPath destinationIndexPath: IndexPath?
    ) -> UITableViewDropProposal {
        let dropProposal = UITableViewDropProposal(operation: .cancel)
        guard session.items.count == 1
        else {
            return dropProposal
        }
        
        if !tableView.hasActiveDrag {
            if selectIndexPath != nil {
                isTablesNotSame = true
            }

            return UITableViewDropProposal(
                operation: .copy,
                intent: .insertAtDestinationIndexPath
            )
        }
        
        return dropProposal
    }
    
    func tableView(
        _ tableView: UITableView,
        performDropWith coordinator: UITableViewDropCoordinator
    ) {
        var destinationIndexPath = IndexPath(
            row: tableView.numberOfRows(inSection: 0),
            section: 0
        )
        if let indexpath = coordinator.destinationIndexPath {
            destinationIndexPath = indexpath
        }
        
        coordinator.session.loadObjects(ofClass: Memo.self) { [self] items in
            guard let subject = items as? [Memo]
            else {
                return
            }
            var indexPaths = [IndexPath]()
            
            for (index, value) in subject.enumerated() {
                let indexPath = IndexPath(
                    row: destinationIndexPath.row + index,
                    section: destinationIndexPath.section
                )
                let viewModel = viewModel(of: tableView)
                viewModel.insert(
                    cell: value,
                    at: indexPath.row
                )

                indexPaths.append(indexPath)
            }
            
            tableView.beginUpdates()
            tableView.insertRows(
                at: indexPaths,
                with: .automatic
            )
            tableView.endUpdates()
            
            updateAllTableRowCount()
        }
    }
}
