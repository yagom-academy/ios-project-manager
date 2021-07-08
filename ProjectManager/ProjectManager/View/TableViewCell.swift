//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCellIdentifier"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var date: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.separatorInset = UIEdgeInsets.zero
    }
    
    func update(info: ViewInfo) {
        title.text = info.title
        summary.text = info.summary
        date.text = info.date
        date.textColor = info.isDateColorRed ? .red : .black
    }
}
