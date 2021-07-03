//
//  TableViewController.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

class TableViewController: UIViewController {
    let viewModel = TableViewModel()
    
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
    
    @objc func didDismissDetailViewControllerNotification(_ notification: Notification) {
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
                let item = viewModel.itemInfo(at: index)
                viewController?.viewModel.update(model: item)
                viewController?.changeToEditMode()
                
                // TODO: - 보다 MVVM에 적합한 방법은 뭘까 고민
                // index 정보를 viewModel에 담아서 전달해도 될까?
                // 여기서는 index정보지만, server에 연결되는 경우엔 item의 고유번호(?)정보를 전달해야함
                viewController?.setItemIndex(index)
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
}
