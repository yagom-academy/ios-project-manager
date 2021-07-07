//
//  TodoTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    static let identifier = "TODOTableViewCellIdentifier"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.separatorInset = UIEdgeInsets.zero
    }
    
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoSummary: UILabel!
    @IBOutlet weak var todoDate: UILabel!
}

extension TodoTableViewCell: TableViewCell {
    func update(info: ViewInfo) {
        todoTitle.text = info.title
        todoSummary.text = info.summary
        todoDate.text = info.date
        todoDate.textColor = info.isDateColorRed ? .red : .black
    }
}
