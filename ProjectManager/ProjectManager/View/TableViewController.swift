//
//  TableViewController.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class TableViewController: UIViewController {
    private let viewModel = TableViewModel()
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    @IBOutlet weak var todoTableRowCount: UILabel!
    @IBOutlet weak var doingTableRowCount: UILabel!
    @IBOutlet weak var doneTableRowCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.dragInteractionEnabled = true
        todoTableView.dragDelegate = self
        todoTableView.dropDelegate = self
        
        doingTableView.delegate = self
//        doingTableView.dataSource = self
        doneTableView.delegate = self
//        doneTableView.dataSource = self
        
        let circleImage = UIImage(systemName: "circle.fill")
        todoTableRowCount.text = "\(viewModel.numOfList)"
        todoTableRowCount.backgroundColor = UIColor(patternImage: circleImage!)
        doingTableRowCount.text = "\(viewModel.numOfList)"
        doingTableRowCount.backgroundColor = UIColor(patternImage: circleImage!) 
        doneTableRowCount.text = "\(viewModel.numOfList)"
        doneTableRowCount.backgroundColor = UIColor(patternImage: circleImage!)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.didDismissDetailViewControllerNotification(_:)),
            name: DetailViewController.dismissNotification,
            object: nil
        )
    }
    
    @objc private func didDismissDetailViewControllerNotification(_ notification: Notification) {
        // TODO: - Server Request
        
        OperationQueue.main.addOperation {
            self.viewModel.update(model: dummy)
            self.todoTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let viewController = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                viewController?.changeToEditMode()
                
                // TODO: - 보다 MVVM에 적합한 방법은 뭘까 고민
                // index 정보를 viewModel에 담아서 전달해도 될까?
                // 여기서는 index정보지만, server에 연결되는 경우엔 item의 고유번호(?)정보를 전달해야함
                viewController?.setViewModel(
                    tableViewModel: viewModel,
                    index: index
                )
            }
        }
    }
    
    @IBAction func clickPlusButton(_ sender: Any) {
        performSegue(
            withIdentifier: "addNewTODO",
            sender: nil
        )
    }
    
    func updateTable() {
        todoTableView.reloadData()
    }
}

// MARK: - UITableView UITableViewDelegate
extension TableViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(
            withIdentifier: "showDetail",
            sender: indexPath.row
        )
    }
}

// MARK: - UITableView UITableViewDataSource
extension TableViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.numOfList
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.cellIdentifier,
            for: indexPath
        ) as? TableViewCell
        else {
            return UITableViewCell()
        }
        
        let listInfo = viewModel.itemInfo(at: indexPath.row)
        cell.update(info: listInfo)
        cell.separatorInset = UIEdgeInsets.zero
        
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
        if (editingStyle == .delete) {
            self.viewModel.removeCell(at: indexPath.row)
            self.updateTable()
        }
    }

    func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        let moveCell = self.viewModel.itemInfo(at: sourceIndexPath.row)
        self.viewModel.removeCell(at: sourceIndexPath.row)
        self.viewModel.insert(
            cell: moveCell,
            at: destinationIndexPath.row
        )
    }
}

// MARK: - UITableView UITableViewDragDelegate
extension TableViewController: UITableViewDragDelegate {
    func tableView(
        _ tableView: UITableView,
        itemsForBeginning session: UIDragSession,
        at indexPath: IndexPath
    ) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

// MARK: - UITableView UITableViewDropDelegate
extension TableViewController: UITableViewDropDelegate {
    func tableView(
        _ tableView: UITableView,
        dropSessionDidUpdate session: UIDropSession,
        withDestinationIndexPath destinationIndexPath: IndexPath?
    ) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(
                operation: .move,
                intent: .insertAtDestinationIndexPath
            )
        }
        return UITableViewDropProposal(
            operation: .cancel,
            intent: .unspecified
        )
    }
    
    func tableView(
        _ tableView: UITableView,
        performDropWith coordinator: UITableViewDropCoordinator
    ) {
        
    }
}
