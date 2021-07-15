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
                self.todoTableView.reloadData()
                self.todoTableRowCount.text = "\(self.todoViewModel.numOfList)"
            }
        }
        
        doingViewModel.memoList.bind { _ in
            DispatchQueue.main.async {
                self.doingTableView.reloadData()
                self.doingTableRowCount.text = "\(self.doingViewModel.numOfList)"
            }
        }
        
        doneViewModel.memoList.bind { _ in
            DispatchQueue.main.async {
                self.doneTableView.reloadData()
                self.doneTableRowCount.text = "\(self.doneViewModel.numOfList)"
            }
        }
        
        self.fetchData()
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
        self.todoViewModel.fetchData()
        self.doingViewModel.fetchData()
        self.doneViewModel.fetchData()
    }
}

// MARK: - View Setting
extension TableViewController {
    private func updateAllTableRowCount() {
        // TODO: - 스크롤 내릴 때, 10개간격으로 fetch시키기
        // 값을 metadata.total로 바꾸자
        // 그렇게 되면, data binding도 구현해야 함..
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
        let item = viewModel.itemInfo(at: indexPath.row)
        if editingStyle == .delete {
            viewModel.removeCell(id: item.id)
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        let viewModel = viewModel(of: tableView)
        let item = viewModel.itemInfo(at: sourceIndexPath.row)
        viewModel.removeCell(id: item.id)
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
            let item = viewModel.itemInfo(at: selectIndexPath.row)
            viewModel.removeCell(id: item.id)
            
            updateTable()
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
        coordinator.session.loadObjects(ofClass: Memo.self) { [self] items in
            guard let subject = items as? [Memo]
            else {
                return
            }
            
            for (_, value) in subject.enumerated() {
                let viewModel = viewModel(of: tableView)
                viewModel.insert(
                    cell: value,
                    destinationTableViewType: viewModel.tableViewType
                )
                
                updateTable()
            }
        }
    }
}
