//
//  CollectionReusableView.swift
//  ProjectManager
//
//  Created by Jusbug on 2023/09/26.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureTitle(title: String, entity: [Entity]) {
        let count = String(entity.count)
        
        headerLabel.text = "\(title) \(count)"
    }
}
