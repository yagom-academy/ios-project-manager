//
//  CollectionReusableView.swift
//  ProjectManager
//
//  Created by 박종화 on 2023/09/26.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureHeaderLabel() {
        if let headerLabel = headerLabel {
            headerLabel.text = "TODO"
        } else {
            // headerLabel이 nil인 경우에 대한 처리
        }
    }
}
