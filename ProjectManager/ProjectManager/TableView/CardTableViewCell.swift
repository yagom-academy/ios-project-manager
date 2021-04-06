//
//  CardTableViewCell.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/06.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionsLable: UILabel!
    @IBOutlet weak var deadlineLable: UILabel!
    
    
    class var identifier: String {
        return "\(self)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
