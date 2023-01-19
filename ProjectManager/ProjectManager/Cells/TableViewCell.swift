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
            gestureRecognizerHelperDelegate?.sendLongPressGesture(gesture: gesture)
        }
    }
}

protocol GestureRecognizerHelperDelegate {
    func sendLongPressGesture(gesture: UIGestureRecognizer)
}
