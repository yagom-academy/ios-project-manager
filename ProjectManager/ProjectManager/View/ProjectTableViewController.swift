import UIKit
import RxSwift
import RxCocoa


private enum UIName {
    
    static let workFormViewStoryboard = "WorkFormView"
    
}

private enum Content {
    
    static let swipeDeleteTitle = "Delete"
    
}

final class ProjectTableViewController: UIViewController {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var countLabel: ProjectHeaderCircleLabel!
    @IBOutlet weak private var tableView: UITableView!
    
    var viewModel: ProjectViewModel?
    var titleText: String?
    var count: Observable<Int>?
    var list: BehaviorSubject<[Work]>?
    
    private var disposeBag = DisposeBag()
    private var selectedWork: Work?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        registerTableViewCell()
        configureHeader()
        configureTableView()
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: String(describing: ProjectTableViewCell.self), bundle: nil)
        
        tableView.register(nib, cellClass: ProjectTableViewCell.self)
    }
    
    private func configureHeader() {
        guard let count = count else { return }
        
        titleLabel.text = titleText
        
        _ = count
            .subscribe(onNext: {
                self.countLabel.text = $0.description
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        guard let list = list else { return }
        
        tableView.delegate = self
        
        list.observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: String(describing: ProjectTableViewCell.self),
                cellType: ProjectTableViewCell.self
            )) { [weak self] _, item, cell in
                cell.configureCellContent(for: item)
                cell.setupData(title: self?.titleText, viewModel: self?.viewModel, work: item)
                
                cell.delegate = self
            }
            .disposed(by: disposeBag)
    }

}

extension ProjectTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        guard let list = list else { return }
        
        let storyboard = UIStoryboard(name: UIName.workFormViewStoryboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            identifier: String(describing: WorkFormViewController.self)
        ) { coder in
            WorkFormViewController(coder: coder, viewModel: viewModel)
        }
        
        var selectedWork: Observable<Work?> {
            list.map { $0[safe: indexPath.row] }
        }
        
        viewController.delegate = viewModel
        viewController.modalPresentationStyle = .formSheet
        viewModel.selectedWork = selectedWork
        
        present(viewController, animated: true, completion: nil)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: Content.swipeDeleteTitle
        ) { [weak self] _, _, _ in
            guard let viewModel = self?.viewModel else { return }
            guard let list = self?.list else { return }
            
            var selectedWork: Observable<Work?> {
                list.map { $0[safe: indexPath.row] }
            }

            _ = selectedWork.subscribe(onNext: { self?.selectedWork = $0 })

            if let work = self?.selectedWork {
                viewModel.removeWork(work)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension ProjectTableViewController: ProjectTableViewCellDelegate {
    func present(alert: UIAlertController) {
        present(alert, animated: true)
    }
}
