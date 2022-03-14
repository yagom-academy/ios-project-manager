import UIKit

class ProjectListTableView: UITableView {
    var state: ProjectState?

    init(state: ProjectState) {
        self.state = state
        super.init(frame: .zero, style: .plain)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        self.backgroundColor = .systemGray6
        self.translatesAutoresizingMaskIntoConstraints = false
        self.registerCell(withClass: ProjectListTableViewCell.self)
        self.registerHeaderFooterView(withClass: ProjectListTableHeaderView.self)
    }
}
