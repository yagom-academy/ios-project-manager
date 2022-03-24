import UIKit

final class ProjectListTableView: UITableView {
    init() {
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
