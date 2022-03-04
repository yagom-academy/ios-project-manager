import UIKit

class ProjectListTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .grouped)
        sectionFooterHeight = 0
        backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
