import UIKit
import RxSwift
import RxCocoa

class ProjectViewController: UIViewController {
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    private let viewModel = ProjectViewModel()
    private var disposeBag = DisposeBag()
    private let actionViewStorboardName = "ActionView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableViews()
    }
    
    @IBAction func addNewWork(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: actionViewStorboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            identifier: String(describing: ActionViewController.self)
        ) { coder in
            ActionViewController(coder: coder, viewModel: self.viewModel)
        }
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray2
    }
    
    private func setupTableViews() {
        configureTableViewCell()
        configureTableViews()
        configureHeader(for: todoTableView, text: "  Todo")
        configureHeader(for: doingTableView, text: "  Doing")
        configureHeader(for: doneTableView, text: "  Done")
    }
    
    private func configureTableViewCell() {
        let nibName = UINib(nibName: String(describing: TableViewCell.self), bundle: nil)
        todoTableView.register(nibName, forCellReuseIdentifier: String(describing: TableViewCell.self))
        doingTableView.register(nibName, forCellReuseIdentifier: String(describing: TableViewCell.self))
        doneTableView.register(nibName, forCellReuseIdentifier: String(describing: TableViewCell.self))
    }
    
    private func configureHeader(for tableView: UITableView, text: String) {
        let header = UIView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: tableView.frame.width,
            height: tableView.frame.height * 0.05
        ))
        let label = UILabel(frame: header.bounds)
        label.text = text
        label.font = .preferredFont(forTextStyle: .largeTitle)
        header.addSubview(label)
        tableView.tableHeaderView = header
    }
    
    private func configureTableViews() {
        viewModel.todoList
            .observe(on: MainScheduler.instance)
            .bind(to: todoTableView.rx.items(
                cellIdentifier: String(describing: TableViewCell.self),
                cellType: TableViewCell.self
            )) { _, item, cell in
                self.configureCellContent(cell, for: item)
            }
            .disposed(by: disposeBag)
        viewModel.doingList
            .observe(on: MainScheduler.instance)
            .bind(to: doingTableView.rx.items(
                cellIdentifier: String(describing: TableViewCell.self),
                cellType: TableViewCell.self
            )) { _, item, cell in
                self.configureCellContent(cell, for: item)
            }
            .disposed(by: disposeBag)
        viewModel.doneList
            .observe(on: MainScheduler.instance)
            .bind(to: doneTableView.rx.items(
                cellIdentifier: String(describing: TableViewCell.self),
                cellType: TableViewCell.self
            )) { _, item, cell in
                self.configureCellContent(cell, for: item)
            }
            .disposed(by: disposeBag)
        
        todoTableView.backgroundColor = .systemGray5
        doingTableView.backgroundColor = .systemGray5
        doneTableView.backgroundColor = .systemGray5
    }
    
    private func configureCellContent(_ cell: TableViewCell, for item: Work) {
        cell.titleLabel.text = item.title
        cell.bodyLabel.text = item.body
        cell.dateLabel.text = item.convertedDate
        
        if item.isExpired {
            cell.dateLabel.textColor = .systemRed
        }
    }
}
