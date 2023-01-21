//
//  TaskCell.swift
//  ProjectManager
//
//  Created by jin on 1/21/23.
//

import UIKit

class TaskCell: UITableViewCell {

    static let cellIdentifier = String.init(describing: TaskCell.self)

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
