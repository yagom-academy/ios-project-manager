import UIKit

class ProjectListTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        self.backgroundColor = .systemGray6
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier)
        self.register(ProjectListTableHeaderView.self, forHeaderFooterViewReuseIdentifier: ProjectListTableHeaderView.identifier)
    }
}
