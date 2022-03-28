import UIKit
import RxSwift
import RxCocoa


private enum UIName {
    
    static let workFormViewStoryboard = "WorkFormView"
    
}

private enum Content {
    
    static let swipeDeleteTitle = "Delete"
    
    static let noContent = "지금은 할 일이 없어요 😅"
    
    static let moveToDoTitle = "Move to TODO"
    static let moveDoingTitle = "Move to DOING"
    static let moveDoneTitle = "Move to DONE"
    
}

final class ProjectTableViewController: UIViewController {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var countLabel: ProjectHeaderCircleLabel!
    @IBOutlet weak private var tableView: UITableView!
    
    private let viewModel = ProjectTableViewModel()
    
    private let viewDidLoadObserver: PublishSubject<Void> = .init()
    private let cellLongPressedObserver: PublishSubject<IndexPath> = .init()
    private let swipeActionObserver: PublishSubject<IndexPath> = .init()
    private let didSelectedObserver: PublishSubject<IndexPath> = .init()
    private let popoverActionObserver: PublishSubject<(String, Work)> = .init()

    private var disposeBag = DisposeBag()
    private var selectedCell: ProjectTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
        viewDidLoadObserver.onNext(())
    }
    
    func setup(viewModel: ProjectViewModel, titleText: String, count: Observable<Int>, list: BehaviorSubject<[Work]>) {
        self.viewModel.setup(
            titleText: titleText,
            count: count, list: list,
            projectViewModel: viewModel
        )
    }
    
    private func bind() {
        let input = ProjectTableViewModel.Input(
            viewDidLoadObserver: viewDidLoadObserver.asObservable(),
            cellLongPressedObserver: cellLongPressedObserver.asObservable(),
            swipeActionObserver: swipeActionObserver.asObservable(),
            didSelectedObserver: didSelectedObserver.asObservable(),
            popoverActionObserver: popoverActionObserver.asObservable()
        )
        let output = viewModel.transform(input)
        
        configureSetupPlaceholderObserver(output)
        configureShowPopoverObserver(output)
        configureDidSelectedObserver(output)
    }
    
    private func configureSetupPlaceholderObserver(_ output: ProjectTableViewModel.Output) {
        let placeholder = UILabel(frame: tableView.frame) // 주인은 없고 사용하는 곳에서 들고 있는 형태 그냥 스토리보드에 만드는 것도 나아보인다. ARC 개념
        
        configurePlaceHolder(for: placeholder)
        
        output.setupPlaceholderObserver
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { works in
                if works.isEmpty {
                    placeholder.isHidden = false
                } else {
                    placeholder.isHidden = true
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func configureShowPopoverObserver(_ output: ProjectTableViewModel.Output) { // 왠만하면 최대한 함수를 쪼개는 것이 좋다. 최대한 짧게 정리를 해보자.
        output.showPopoverObserver
            .subscribe(onNext: { [weak self] work in
                let firstTitle: String = {
                    switch work.categoryTag {
                    case Work.Category.todo.tag:
                        return Content.moveDoingTitle
                    default:
                        return Content.moveToDoTitle
                    }
                }() // 이렇게 변경할 수 있다. var를 경계하자.
                
                var secondTitle: String {
                    switch work.categoryTag {
                    case Work.Category.done.tag:
                        return Content.moveDoingTitle
                    default:
                        return Content.moveDoneTitle
                    }
                }
                
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let firstAction = UIAlertAction(title: firstTitle, style: .default) { [weak self] _ in
                    self?.popoverActionObserver.onNext((firstTitle, work))
                }
                let secondAction = UIAlertAction(title: secondTitle, style: .default) { [weak self] _ in
                    self?.popoverActionObserver.onNext((secondTitle, work))
                }

                alert.addAction(firstAction)
                alert.addAction(secondAction)
                alert.popoverPresentationController?.sourceView = self?.selectedCell
                
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureDidSelectedObserver(_ output: ProjectTableViewModel.Output) {
        output.showWorkFormViewObserver
            .subscribe(onNext: { [weak self] work in
                let storyboard = UIStoryboard(name: UIName.workFormViewStoryboard, bundle: nil) // 스토리보드를 쓰면 이 과정을 반복해야 한다. 
                guard let viewController = storyboard.instantiateViewController(
                    identifier: String(describing: WorkFormViewController.self)
                ) as? WorkFormViewController else {
                    return
                }
                
                viewController.setup(
                    selectedWork: work,
                    list: self!.viewModel.list
                )
                viewController.modalPresentationStyle = .formSheet

                self?.present(viewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
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
        guard let count = viewModel.count else { return }

        titleLabel.text = viewModel.titleText

        count
            .subscribe(onNext: {
                self.countLabel.text = $0.description
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        
        viewModel.list.observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: String(describing: ProjectTableViewCell.self),
                cellType: ProjectTableViewCell.self
            )) { [weak self] _, item, cell in
                cell.configureCellContent(for: item)
                cell.setupData(work: item)
                
                cell.delegate = self
            }
            .disposed(by: disposeBag)
    }
    
    private func configurePlaceHolder(for placeholder: UILabel) {
        placeholder.text = Content.noContent
        placeholder.textColor = .systemGray
        placeholder.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        placeholder.textAlignment = .center
        
        self.view.addSubview(placeholder)
        
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        placeholder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

extension ProjectTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedObserver.onNext(indexPath)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: Content.swipeDeleteTitle
        ) { [weak self] _, _, _ in
            self?.swipeActionObserver.onNext(indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension ProjectTableViewController: ProjectTableViewCellDelegate {
    
    func longpressed(at cell: ProjectTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        selectedCell = cell
        cellLongPressedObserver.onNext(indexPath)
    }
    
}
