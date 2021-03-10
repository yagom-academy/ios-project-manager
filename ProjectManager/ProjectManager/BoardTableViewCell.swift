//
//  BoardTableViewCell.swift
//  ProjectManager
//
//  Created by 강인희 on 2021/03/09.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    static let identifier = "BoardTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.titleLabel.text = "titleLabel"
        self.descriptionLabel.text = """
            storyboard file instead.UIKit separates the content of your view controllers from the way that content is presented and displayed onscreen. Presented view controllers are managed by an underlying presentation controller object, which manages the visual style used to display the view controller’s view. A presentation controller may do the following:Set the size of the presented view controller.Add custom views to change the visual appearance of the presented content.Supply transition animations for any of its custom views.Adapt the visual appearance of the presentation when changes occur in the app’s environment.UIKit provides presentation controllers for the standard presentation styles. When you set the presentation style of a view controller to UIModalPresentationCustom and provide an appropriate transitioning delegate, UIKit uses your custom presentation controller instead.
            """
        self.dueDateLabel.text = "dueDateLabel"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
