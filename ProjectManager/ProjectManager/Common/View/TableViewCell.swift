//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import UIKit

class TableViewCell: UITableViewCell {
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

        if checkPastDate(date: data.taskDeadline) {
            deadlineLabel.textColor = .red
        }
    }

    private func checkPastDate(date: String) -> Bool {
        let deadline = Int(date.filter { $0.isNumber }) ?? 0

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let currentDate = Int(formatter.string(from: Date())) ?? 0

        if currentDate > deadline {
            return true
        }

        return false
    }
}
