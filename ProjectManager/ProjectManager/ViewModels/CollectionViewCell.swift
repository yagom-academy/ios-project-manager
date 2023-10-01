//
//  CollectionViewCell.swift
//  ProjectManager
//
//  Created by 박종화 on 2023/09/23.
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
        titleLabel.text = entity.title
        bodyLabel.text = entity.body
        durationLabel.text = "Duration"
        durationLabel.textColor = .red
    }
}
