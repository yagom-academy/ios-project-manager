//
//  HistoryTableViewCell.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/28.
//

import UIKit

class HistoryTableViewCell: UITableViewCell, ReuseIdentifying {

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpCell(data: HistoryModel) {
        bodyLabel.text = data.body
        dateLabel.text = data.date
    }
}
