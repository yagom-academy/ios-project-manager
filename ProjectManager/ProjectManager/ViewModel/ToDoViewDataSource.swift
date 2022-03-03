//
//  ToDoViewDataSource.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/03.
//

import UIKit

final class ToDoViewDataSource: NSObject {
    let testDataManager = TestDataManager()
}

extension ToDoViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDocell", for: indexPath) as? ToDocell else {
            return UITableViewCell()
        }
        return cell
    }
}
