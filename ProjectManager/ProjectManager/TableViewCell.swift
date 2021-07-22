//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 배은서 on 2021/07/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    static let identifier = "TableViewCell"
    
    var formattedDeadLineDate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.dueDateLabel.textColor = .black
    }
    
    func configure(_ task: Task) {
        self.titleLabel.text = task.title
        self.contentLabel.text = task.content
        self.dueDateLabel.text = task.formattedDeadLineDate
        
        if isOutDated(task.deadLineDate) {
            self.dueDateLabel.textColor = .red
        } else {
            self.dueDateLabel.textColor = .black
        }
    }
    
    private func isOutDated(_ date: Date) -> Bool {
        let currentDate = Date()

        let interval = date.timeIntervalSince(currentDate)
        let days = Int(interval / 86400)

        return days < 0
    }
}
