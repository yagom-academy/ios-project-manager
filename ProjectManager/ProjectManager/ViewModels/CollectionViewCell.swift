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

    func configureLabels() {
        titleLabel.text = "Title"
        bodyLabel.text = "Description"
        durationLabel.text = "Duration"
        durationLabel.textColor = .red
    }
}
