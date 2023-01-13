//
//  CustomTableView.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/13.
//

import UIKit

final class CustomTableView: UITableView {
    var string = String()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        
        self.register(TodoCustomCell.self, forCellReuseIdentifier: "TodoCustomCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: -Cell확인
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: "TodoCustomCell",
            for: indexPath
        ) as? TodoCustomCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = "This is Title"
        cell.bodyLabel.text = "This is Body"
        cell.dateLabel.text = "This is Date"
        
        return cell
    }
}

extension CustomTableView: UITableViewDelegate {
    
}
