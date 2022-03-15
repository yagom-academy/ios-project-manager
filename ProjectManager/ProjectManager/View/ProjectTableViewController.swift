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
    
    private var disposeBag = DisposeBag()
    private var viewModel: ProjectViewModel?
    private var titleText: String?
    private var count: Observable<Int>?
    private var list: BehaviorSubject<[Work]>?
    private var selectedWork: Work?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let placeholder = UILabel(frame: tableView.bounds)
        configurePlaceHolder(for: placeholder)
        
        _ = list?.subscribe(onNext: {
            if $0.isEmpty {
                placeholder.isHidden = false
            } else {
                placeholder.isHidden = true
            }
        })
    }
    
    private func configurePlaceHolder(for placeholder: UILabel) {
            placeholder.text = "지금은 할 일이 없어요 😅"
            placeholder.textColor = .systemGray
            placeholder.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            placeholder.textAlignment = .center
            
            self.view.addSubview(placeholder)
            
            placeholder.translatesAutoresizingMaskIntoConstraints = false
            placeholder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            placeholder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            placeholder.isHidden = true
        }
    
    func setup(viewModel: ProjectViewModel) {
        self.viewModel = viewModel
    }
    
    func setup(titleText: String, count: Observable<Int>, list: BehaviorSubject<[Work]>) {
        self.titleText = titleText
        self.count = count
        self.list = list
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
