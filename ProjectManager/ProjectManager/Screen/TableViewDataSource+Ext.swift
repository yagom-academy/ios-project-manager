//
//  TableViewDataSource+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

extension ProjectManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ProjectManagerTableViewCell()
        cell.titleLabel.text = "금연하기"
        cell.descriptionLabel.text = "담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스,담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스"
        cell.dateLabel.text = "2021.07.01"
        
        return cell
    }
}
