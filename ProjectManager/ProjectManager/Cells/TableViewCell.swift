//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/12.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var gestureRecognizerHelperDelegate: GestureRecognizerHelperDelegate?
    private var gesture: UILongPressGestureRecognizer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGesture()
    }
    
    func configureCell(task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        dateLabel.text = task.date?.formattedDateToString()
        setDataLabelRed(task: task)
    }
    
    private func setDataLabelRed(task: Task) {
        guard let taskDate = task.date else { return }
        if taskDate <= Date() {
            dateLabel.textColor = .red
        }
    }
        
    private func addGesture() {
        gesture = UILongPressGestureRecognizer(target: self,
                                               action: #selector(handleLongPress))
        if let gesture = gesture {
            addGestureRecognizer(gesture)
        }
    }
    
    @objc
    private func handleLongPress() {
        if let gesture = gesture {
            gestureRecognizerHelperDelegate?.sendLongPressGesture(gesture)
        }
    }
}

protocol GestureRecognizerHelperDelegate {
    func sendLongPressGesture(_ sender: UILongPressGestureRecognizer)
}
