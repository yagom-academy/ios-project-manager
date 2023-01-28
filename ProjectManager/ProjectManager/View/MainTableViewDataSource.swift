//
//  MainTableViewDataSource.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/28.
//

import UIKit

final class MainTableViewDataSource: NSObject, UITableViewDataSource, TableViewMethoding {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCell(of: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedReusableCell = tableView.dequeueReusableCell(
            withIdentifier: "TodoCustomCell",
            for: indexPath
        )
        guard let cell = dequeuedReusableCell as? TodoCustomCell else { return UITableViewCell() }
        
        let data = saveData(of: tableView, to: indexPath.row)
        
        guard let todoDate = data?.todoDate else { return cell }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        cell.titleLabel.text = data?.title
        cell.bodyLabel.text = data?.body
        cell.dateLabel.text = dateFormatter.string(from: todoDate)
        
        if todoDate < Date() {
            cell.dateLabel.textColor = .red
        }
        
        return cell
    }
}
