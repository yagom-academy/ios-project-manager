import UIKit

class ProjectListTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
