//
//  CollectionViewCell.swift
//  ProjectManager
//
//  Created by 박종화 on 2023/09/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLabels()
    }

    private func configureLabels() {
        titleLabel.text = "Title"
        descriptionLabel.text = "Description"
        durationLabel.text = "Duration"
        durationLabel.textColor = .red
    }
}
