//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 배은서 on 2021/07/20.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var numberButton: UIButton!
    
    static let identifier = "HeaderView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberButton.layer.cornerRadius = 0.5 * numberButton.bounds.size.width
    }
    
}
