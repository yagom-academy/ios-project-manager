import UIKit
import RxSwift
import RxCocoa


class ProjectViewController: UIViewController {
    
    private let viewModel = ProjectViewModel()
    private var disposeBag = DisposeBag()
    private let formSheetViewStorboardName = "WorkFormView"
    
    @IBOutlet weak private var todoTableView: UITableView!
    @IBOutlet weak private var doingTableView: UITableView!
    @IBOutlet weak private var doneTableView: UITableView!
    @IBOutlet weak private var todoTitleLabel: UILabel!
    @IBOutlet weak private var todoCountLabel: UILabel!
    @IBOutlet weak private var doingTitleLabel: UILabel!
    @IBOutlet weak private var doingCountLabel: UILabel!
    @IBOutlet weak private var doneTitleLabel: UILabel!
    @IBOutlet weak private var doneCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableViews()
    }
    
    @IBAction private func addNewWork(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: formSheetViewStorboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            identifier: String(describing: WorkFormViewController.self)
        ) { coder in
            WorkFormViewController(coder: coder, viewModel: self.viewModel)
        }
        viewController.modalPresentationStyle = .formSheet
        
        present(viewController, animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
    }
    
    private func setupTableViews() {
        configureTableViewCells()
        configureTableViews()
        configureHeaders()
    }
    
    private func configureTableViewCells() {
        let nibName = UINib(nibName: String(describing: ProjectTableViewCell.self), bundle: nil)
        
        todoTableView.register(nibName, forCellReuseIdentifier: String(describing: ProjectTableViewCell.self))
        doingTableView.register(nibName, forCellReuseIdentifier: String(describing: ProjectTableViewCell.self))
        doneTableView.register(nibName, forCellReuseIdentifier: String(describing: ProjectTableViewCell.self))
    }
    
    private func configureHeaders() {
        todoTitleLabel.text = "TODO"
        doingTitleLabel.text = "DOING"
        doneTitleLabel.text = "DONE"
        
        todoCountLabel.layer.cornerRadius = 12
        doingCountLabel.layer.cornerRadius = 12
        doneCountLabel.layer.cornerRadius = 12
        
        todoCountLabel.layer.masksToBounds = true
        doingCountLabel.layer.masksToBounds = true
        doneCountLabel.layer.masksToBounds = true
        
        _ = viewModel.todoCount
            .subscribe(onNext: {
                self.todoCountLabel.text = $0.description
            })
            .disposed(by: disposeBag)
        _ = viewModel.doingCount
            .subscribe(onNext: {
                self.doingCountLabel.text = $0.description
            })
            .disposed(by: disposeBag)
        _ = viewModel.doneCount
            .subscribe(onNext: {
                self.doneCountLabel.text = $0.description
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTableViews() {
        viewModel.todoList
            .observe(on: MainScheduler.instance)
            .bind(to: todoTableView.rx.items(
                cellIdentifier: String(describing: ProjectTableViewCell.self),
                cellType: ProjectTableViewCell.self
            )) { _, item, cell in
                cell.configureCellContent(for: item)
            }
            .disposed(by: disposeBag)
        viewModel.doingList
            .observe(on: MainScheduler.instance)
            .bind(to: doingTableView.rx.items(
                cellIdentifier: String(describing: ProjectTableViewCell.self),
                cellType: ProjectTableViewCell.self
            )) { _, item, cell in
                cell.configureCellContent(for: item)
            }
            .disposed(by: disposeBag)
        viewModel.doneList
            .observe(on: MainScheduler.instance)
            .bind(to: doneTableView.rx.items(
                cellIdentifier: String(describing: ProjectTableViewCell.self),
                cellType: ProjectTableViewCell.self
            )) { _, item, cell in
                cell.configureCellContent(for: item)
            }
            .disposed(by: disposeBag)
        
        todoTableView.backgroundColor = .systemGray5
        doingTableView.backgroundColor = .systemGray5
        doneTableView.backgroundColor = .systemGray5
    }
    
}
