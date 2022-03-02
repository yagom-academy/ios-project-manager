import UIKit

class ProjectListTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier)
    }
}
