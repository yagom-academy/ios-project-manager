import UIKit

class MainUIView: UIView {

    private let todoTableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell())
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let doingTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell())
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let doneTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell())
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.todoTableView,
                self.doingTableView,
                self.doneTableView
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureTableView() {
        self.addSubview(stackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
}
