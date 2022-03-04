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
        self.registerCell(withClass: ProjectTableViewCell.self)
        self.registerHeaderFooterView(withClass: ProjectListTableHeaderView.self)
    }
}
