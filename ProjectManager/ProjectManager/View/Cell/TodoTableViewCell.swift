//
//  TodoTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoSummary: UILabel!
    @IBOutlet weak var todoDate: UILabel!
    
    func update(info: TableItem) {
        self.backgroundColor = UIColor.clear
        
        todoTitle.text = info.title
        todoSummary.text = info.summary
        todoDate.text = dateConverter.numberToString(number: info.date)
        
        let stringOfCurrentDate = dateConverter.dateToString(date: Date())
        if todoDate.text ?? "" < stringOfCurrentDate {
            todoDate.textColor = UIColor.red
        } else {
            todoDate.textColor = UIColor.black
        }
    }
}
