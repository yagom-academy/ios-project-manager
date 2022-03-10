import UIKit
import RxSwift
import RxCocoa


private enum Content {
    static let workFormViewStoryboardName = "WorkFormView"
    static let todoTitle = "TODO"
    static let doingTitle = "DOING"
    static let doneTitle = "DONE"
}

private enum Design {
    static let tableViewBackgroundColor: UIColor = .systemGray5
    static let viewBackgroundColor: UIColor = .systemGray6
}

final class ProjectViewController: UIViewController {
    
    private let viewModel = ProjectViewModel()
    private var disposeBag = DisposeBag()
    private let formSheetViewStorboardName = Content.workFormViewStoryboardName
    
    @IBOutlet weak private var todoTableView: UITableView!
    @IBOutlet weak private var doingTableView: UITableView!
    @IBOutlet weak private var doneTableView: UITableView!
    @IBOutlet weak private var todoTitleLabel: UILabel!
    @IBOutlet weak private var todoCountLabel: ProjectHeaderCircleLabel!
    @IBOutlet weak private var doingTitleLabel: UILabel!
    @IBOutlet weak private var doingCountLabel: ProjectHeaderCircleLabel!
    @IBOutlet weak private var doneTitleLabel: UILabel!
    @IBOutlet weak private var doneCountLabel: ProjectHeaderCircleLabel!
    
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
        view.backgroundColor = Design.viewBackgroundColor
    }
    
    private func setupTableViews() {
        configureTableViewCells()
        configureTableViews()
        configureHeaders()
    }
    
    private func configureTableViewCells() {
        let nibName = UINib(nibName: String(describing: ProjectTableViewCell.self), bundle: nil)
        
        todoTableView.register(nibName, cellClass: ProjectTableViewCell.self)
        doingTableView.register(nibName, cellClass: ProjectTableViewCell.self)
        doneTableView.register(nibName, cellClass: ProjectTableViewCell.self)
    }
    
    private func configureHeaders() {
        todoTitleLabel.text = Content.todoTitle
        doingTitleLabel.text = Content.doingTitle
        doneTitleLabel.text = Content.doneTitle
        
        _ = viewModel.todoCount
            .subscribe(onNext: { [weak self] in
                self?.todoCountLabel.text = $0.description
            })
            .disposed(by: disposeBag)
        
        _ = viewModel.doingCount
            .subscribe(onNext: { [weak self] in
                self?.doingCountLabel.text = $0.description
            })
            .disposed(by: disposeBag)
        
        _ = viewModel.doneCount
            .subscribe(onNext: { [weak self] in
                self?.doneCountLabel.text = $0.description
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
        
        todoTableView.backgroundColor = Design.tableViewBackgroundColor
        doingTableView.backgroundColor = Design.tableViewBackgroundColor
        doneTableView.backgroundColor = Design.tableViewBackgroundColor
    }
    
}
