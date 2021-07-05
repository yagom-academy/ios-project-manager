//
//  DoneTableViewCell.swift
//  ProjectManager
//
//  Created by 이성노 on 2021/06/30.
//

import UIKit

class DoneTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DoneTableViewCell: CellConfigurable {
    func configure(tasks: [Task], rowAt row: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        titleLabel.text = tasks[row].title
        contentLabel.text = tasks[row].content
        dateLabel.text = dateFormatter.string(from: tasks[row].date)
    }
}
