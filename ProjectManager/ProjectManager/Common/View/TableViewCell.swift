//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import UIKit

class TableViewCell: UITableViewCell, ReuseIdentifying {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpCell(data: TaskModel) {
        titleLabel.text = data.taskTitle
        descriptionLabel.text = data.taskDescription
        deadlineLabel.text = data.taskDeadline
        deadlineLabel.textColor = data.checkPastDate()
    }
}
