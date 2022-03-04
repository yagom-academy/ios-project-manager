import UIKit

class ProjectListTableView: UITableView {
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        
        return titleLabel
    }()
    
    let underLine: UIView = {
        let underLine = UIView()
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.backgroundColor = .systemGray2
        
        return underLine
    }()
    
    let badgeLabel: UILabel = {
        let badgeLabel = UILabel()
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.font = .preferredFont(forTextStyle: .caption2)
        badgeLabel.textColor = .systemBackground
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = .label
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.text = "0"
        
        return badgeLabel
    }()
    
    private lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .secondarySystemBackground
        
        return headerView
    }()

    init(title: String) {
        super.init(frame: .zero, style: .grouped)
        titleLabel.text = title
        setupTableHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableHeaderView() {
        tableHeaderView = headerView
        tableHeaderView?.frame.size.height = 55
        setupHeaderViewLayout()
    }
    
    private func setupHeaderViewLayout() {
        headerView.addSubview(titleLabel)
        headerView.addSubview(underLine)
        headerView.addSubview(badgeLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -2.5),
            badgeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            badgeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            badgeLabel.widthAnchor.constraint(equalToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20),
            underLine.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            underLine.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            underLine.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            underLine.heightAnchor.constraint(equalToConstant: 0.3)
        ])
    }
    
    func countProject(number: Int) {
        badgeLabel.text = number.description
    }
}
