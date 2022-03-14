import UIKit

class ProjectListTableView: UITableView {
    var state: State

    init(state: State) {
        self.state = state
        super.init(frame: .zero, style: .plain)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .systemGray6
        self.translatesAutoresizingMaskIntoConstraints = false
        self.registerCell(withClass: ProjectListTableViewCell.self)
        self.registerHeaderFooterView(withClass: ProjectListTableHeaderView.self)
    }
}
