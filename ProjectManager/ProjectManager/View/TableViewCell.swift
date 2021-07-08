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
    
    func update(info: MemoTableViewCellModel) {
        title.text = info.title
        summary.text = info.content
        date.text = info.date
        date.textColor = info.isDateColorRed ? .red : .black
    }
}
