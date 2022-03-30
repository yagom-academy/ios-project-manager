import UIKit

final class MainListUIView: UIView {
    
    private var todoTableView: UITableView?
    private var doingTableView: UITableView?
    private var doneTableView: UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureTableViews()
        self.addViews()
        self.configureLayout()
        self.setUpHeaderView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func extractTableViews() -> [UITableView] {
        return [self.todoTableView, self.doingTableView, self.doneTableView].compactMap{ $0 }
    }
    
    private func tableViewFactory() -> UITableView {
        let tableview = UITableView(frame: .zero)
        tableview.register(
            ListUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ListUITableViewCell.self)
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private func addViews() {
        self.addSubview(stackView)
    }
    
    private func configureTableViews() {
        self.todoTableView = self.tableViewFactory()
        self.doingTableView = self.tableViewFactory()
        self.doneTableView = self.tableViewFactory()
    }
    
    private func configureLayout() {
        let tableviews = self.extractTableViews()
        tableviews.forEach{ self.stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpHeaderView() {
        let tableViews = self.extractTableViews()
        tableViews.forEach { tableview in
            let headerView = TableViewHeaderUIView(frame: CGRect(x: 0, y: 0, width: tableview.frame.width - 10, height: 60))
            headerView.backgroundColor = .brown
            tableview.tableHeaderView = headerView
        }
    }
}
