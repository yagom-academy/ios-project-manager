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
        let work = Work(title: "새로운 데이터", body: "새로운 바디", dueDate: Date(), sort: .doing)
        viewModel.addWork(work)
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
        
        configureTableViews()
    }
    
    private func configureTableViews() {
        viewModel.todoList
            .observe(on: MainScheduler.instance)
            .bind(to: todoTableView.rx.items(
                cellIdentifier: "TableViewCell",
                cellType: TableViewCell.self
            )) { _, item, cell in
                self.configureCell(cell, for: item)
            }
            .disposed(by: disposeBag)
        viewModel.doingList
            .observe(on: MainScheduler.instance)
            .bind(to: doingTableView.rx.items(
                cellIdentifier: "TableViewCell",
                cellType: TableViewCell.self
            )) { _, item, cell in
                self.configureCell(cell, for: item)
            }
            .disposed(by: disposeBag)
        viewModel.doneList
            .observe(on: MainScheduler.instance)
            .bind(to: doneTableView.rx.items(
                cellIdentifier: "TableViewCell",
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
