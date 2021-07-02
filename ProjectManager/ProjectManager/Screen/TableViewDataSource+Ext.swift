//
//  TableViewDataSource+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

extension ProjectManagerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectManagerTableViewCell") as? ProjectManagerTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = "금연하기"
        cell.descriptionLabel.text = "담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스,담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스"
        cell.dateLabel.text = "2021.07.01"
        
        return cell
    }
}
