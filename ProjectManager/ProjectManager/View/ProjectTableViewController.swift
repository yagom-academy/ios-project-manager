import UIKit
import RxSwift
import RxCocoa


private enum UIName {
    static let workFormViewStoryboard = "WorkFormView"
}

final class ProjectTableViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: ProjectHeaderCircleLabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    var viewModel: ProjectViewModel?
    var titleText: String?
    var count: Observable<Int>?
    var list: BehaviorSubject<[Work]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
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
            )) { _, item, cell in
                cell.configureCellContent(for: item)
            }
            .disposed(by: disposeBag)
    }

}

extension ProjectTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        guard let list = list else { return }

        var work: Observable<Work?> {
            list.map { $0[safe: indexPath.row] }
        }
        
        let storyboard = UIStoryboard(name: UIName.workFormViewStoryboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            identifier: String(describing: WorkFormViewController.self)
        ) { coder in
            WorkFormViewController(coder: coder, viewModel: viewModel)
        }
        viewController.modalPresentationStyle = .formSheet
        viewController.setupContent(from: work)
        
        present(viewController, animated: true, completion: nil)
    }
    
}
