import UIKit
import RxSwift
import RxCocoa

class ProjectViewController: UIViewController {
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    let viewModel = ProjectViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableViews()
    }
    
    @IBAction func addNewWork(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "ActionView", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ActionView") { coder in
            ActionViewController(coder: coder, viewModel: self.viewModel)
        }
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray2
    }
    
    private func setupTableViews() {
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        todoTableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        doingTableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        doneTableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        todoTableView.backgroundColor = .systemGray5
        doingTableView.backgroundColor = .systemGray5
        doneTableView.backgroundColor = .systemGray5
        
        configureTableViews()
        configureHeader(for: todoTableView, text: "  Todo")
        configureHeader(for: doingTableView, text: "  Doing")
        configureHeader(for: doneTableView, text: "  Done")
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
                cellIdentifier: TableViewCell.identifier,
                cellType: TableViewCell.self
            )) { _, item, cell in
                self.configureCell(cell, for: item)
            }
            .disposed(by: disposeBag)
        viewModel.doingList
            .observe(on: MainScheduler.instance)
            .bind(to: doingTableView.rx.items(
                cellIdentifier: TableViewCell.identifier,
                cellType: TableViewCell.self
            )) { _, item, cell in
                self.configureCell(cell, for: item)
            }
            .disposed(by: disposeBag)
        viewModel.doneList
            .observe(on: MainScheduler.instance)
            .bind(to: doneTableView.rx.items(
                cellIdentifier: TableViewCell.identifier,
                cellType: TableViewCell.self
            )) { _, item, cell in
                self.configureCell(cell, for: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureCell(_ cell: TableViewCell, for item: Work) {
        cell.titleLabel.text = item.title
        cell.bodyLabel.text = item.body
        cell.dateLabel.text = item.convertedDate
    }
}
