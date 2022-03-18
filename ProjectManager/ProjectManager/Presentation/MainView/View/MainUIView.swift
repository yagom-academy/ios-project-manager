import UIKit

class MainUIView: UIView {

    let todoTableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell.self)
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let doingTableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell.self)
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let doneTableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell.self)
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
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
        let tableviews = [todoTableView,doingTableView,doneTableView]
        tableviews.forEach{ stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
