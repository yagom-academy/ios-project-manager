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
        
        let circleImage = UIImage(systemName: "circle.fill")
        todoTableRowCount.text = "\(viewModel.numOfList)"
        todoTableRowCount.backgroundColor = UIColor(patternImage: circleImage!)
        doingTableRowCount.backgroundColor = UIColor(patternImage: circleImage!) 
        doneTableRowCount.backgroundColor = UIColor(patternImage: circleImage!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let viewController = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                let item = viewModel.itemInfo(at: index)
                viewController?.viewModel.update(model: item)
                viewController?.changeToEditMode()
            }
        }
    }
    
    @IBAction func clickPlusButton(_ sender: Any) {
        performSegue(
            withIdentifier: "addNewTODO",
            sender: nil
        )
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
