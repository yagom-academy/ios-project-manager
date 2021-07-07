//
//  DoingTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import UIKit

final class DoingTableViewCell: UITableViewCell {
    static let identifier = "DoingTableViewCellIdentifier"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.separatorInset = UIEdgeInsets.zero
    }
    
    @IBOutlet weak var doingTitle: UILabel!
    @IBOutlet weak var doingSummary: UILabel!
    @IBOutlet weak var doingDate: UILabel!
}

extension DoingTableViewCell: TableViewCell {
    func update(info: ViewInfo) {
        doingTitle.text = info.title
        doingSummary.text = info.summary
        doingDate.text = info.date
        doingDate.textColor = info.isDateColorRed ? .red : .black
    }
}
