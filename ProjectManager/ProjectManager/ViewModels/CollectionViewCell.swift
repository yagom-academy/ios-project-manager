//
//  CollectionViewCell.swift
//  ProjectManager
//
//  Created by Jusbug on 2023/09/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureLabels(entity: Entity) {
        guard let date = entity.duration else { return }
        let formattedDate = DateFormatManager.formatDate(date: date)
        
        titleLabel.text = entity.title
        bodyLabel.text = entity.body
        durationLabel.text = formattedDate
    }
    
    func configureDurationTextColor(entity: Entity) {
        guard let date = entity.duration else { return }
        let currentDate = Date()
        
        if date < currentDate {
            durationLabel.textColor = .red
        } else {
            durationLabel.textColor = .black
        }
    }
}
