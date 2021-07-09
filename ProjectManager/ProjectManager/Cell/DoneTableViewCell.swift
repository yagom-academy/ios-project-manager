//
//  DoneTableViewCell.swift
//  ProjectManager
//
//  Created by Jay, Ian, James on 2021/06/30.
//

import UIKit

class DoneTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DoneTableViewCell: CellConfigurable {
    func configure(tasks: [Task], rowAt row: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.customize(dateStyle: .medium, timeStyle: .none, dateFormat: "yyyy. MM. dd")
        titleLabel.text = tasks[row].title
        contentLabel.text = tasks[row].content
        dateLabel.text = dateFormatter.string(from: tasks[row].deadlineDate)
        changeOutDatedLabelColor(date: tasks[row].deadlineDate)
    }
    
    func isOutDated(date: Date) -> Bool {
        return Date() > date
    }
    
    func changeOutDatedLabelColor(date: Date) {
        if isOutDated(date: date) == true {
            return dateLabel.textColor = .red
        } else {
            return dateLabel.textColor = .black
        }
    }
}
