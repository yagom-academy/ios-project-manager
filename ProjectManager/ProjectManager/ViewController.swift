import UIKit

class ViewController: UIViewController {
    let todoTableView = ProjectListTableView()
    let doingTableView = ProjectListTableView()
    let doneTableView = ProjectListTableView()
    
    lazy var entireStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
        stackview.axis = .horizontal
        stackview.spacing = 5
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        self.view.backgroundColor = .gray
        self.navigationController?.isToolbarHidden = false
        configureEntireStackView()
        configureLayout()
    }
    
    func configureEntireStackView() {
        self.view.addSubview(entireStackView)
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            self.entireStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.entireStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.entireStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.entireStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
}

