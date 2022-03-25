import UIKit


class ProjectHeaderCircleLabel: UILabel {
    //bounds가 변경되면 height / width가 변경이 되야 항상 Circle이 될 수 있다.
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.width / 2 // 이 또한 변경이 되야 
        self.layer.masksToBounds = true
    }

}
