import UIKit


class ProjectHeaderCircleLabel: UILabel {
    
    // MARK: - Override Method
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }

}
