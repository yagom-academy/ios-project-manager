//
//  DoneTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import UIKit

final class DoneTableViewCell: UITableViewCell {
    static let identifier = "DoneTableViewCellIdentifier"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.separatorInset = UIEdgeInsets.zero
    }
    
    @IBOutlet weak var doneTitle: UILabel!
    @IBOutlet weak var doneSummary: UILabel!
    @IBOutlet weak var doneDate: UILabel!
}

extension DoneTableViewCell: TableViewCell {
    func update(info: ViewInfo) {
        doneTitle.text = info.title
        doneSummary.text = info.summary
        doneDate.text = info.date
        doneDate.textColor = info.isDateColorRed ? .red : .black
    }
}
