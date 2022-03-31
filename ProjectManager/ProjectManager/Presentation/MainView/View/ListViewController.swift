import UIKit
import RxSwift
import RxCocoa

final class ListViewController: UIViewController {
    
    // MARK: - properties
    var viewModel: ListViewModel?
    private let disposeBag = DisposeBag()
    private var customView = MainListUIView()
    private let popoverView = popoverUIView()
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMainView()
        self.configureLayout()
        self.configureNavigationItems()
        let input = self.configureInput()
        self.configureOutput(input: input)
        self.configureLongPressGesture()
    }
    
  // MARK: - methods
    private func configureLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 1.0
        let tableviews = customView.extractTableViews()
        tableviews.forEach { tableview in
            tableview.addGestureRecognizer(longPressGesture)
        }
    }
    
    @objc
    func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) { // 팝오버를 띄워줄 위치 , 정보를 받는다. 
        guard let tableView = gestureRecognizer.view as? UITableView
        else {
            return
        }
       
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: tableView)
            
        }
       
    }

    private func presentPopOver(at view: UIView) {
        let popoverViewController: UIViewController = {
            let popOver = UIViewController()
            popOver.view = self.popoverView
            popOver.modalPresentationStyle = .popover
            popOver.preferredContentSize = CGSize(width: 200, height: 100)
            popOver.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            popOver.popoverPresentationController?.sourceView = view
            
            return popOver
        }()
        
        self.present(popoverViewController, animated: false)
    }

    private func configureMainView() {
        view.addSubview(customView)
        view.backgroundColor = .white
        self.customView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNavigationItems() {
        self.navigationItem.title = "ProjectManager"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.customView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.customView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.customView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.customView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: - bind UI w/ RxSwift 
    private func configureInput() -> ListViewModel.Input {
        let tableViews = self.customView.extractTableViews()
        let rightBarButton = self.extractRightBarButtonItem()
        let input = ListViewModel
            .Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in },
             projectAddButtonTapped:
                rightBarButton.rx.tap.asObservable(),
            projectDeleteEvent:
                tableViews.map{ $0.rx.modelDeleted(Project.self).map { $0.identifier }}, projectDidtappedEvent:
                    tableViews.map{ $0.rx.modelSelected(Project.self).map { $0.identifier } }
            )
        
        return input
    }
        
    private func configureOutput(input: ListViewModel.Input) {
        let output = self.viewModel?.transform(input: input, disposeBag: self.disposeBag)
        let tableViews = self.customView.extractTableViews()
        let listsOutputs = [output?.todoProjects, output?.doingProjects, output?.doneProjects]
        let numberOutputs = [output?.todoCounts, output?.doingCounts, output?.doneCounts]
        let listZip = Dictionary(uniqueKeysWithValues: zip(tableViews, listsOutputs))
        let countZip = Dictionary(uniqueKeysWithValues: zip(tableViews, numberOutputs))
        
        listZip.forEach { tableview, output in
            output?.asDriver(onErrorJustReturn: [])
            .drive(tableview.rx.items(cellIdentifier: String(describing: ListUITableViewCell.self), cellType: ListUITableViewCell.self)) { index, item, cell in
                cell.configureCellUI(data: item)
            }.disposed(by: self.disposeBag)
        }
        
        countZip.forEach { tableview, output in
            output?.subscribe(onNext: { number in
                tableview.rx.setUpHeaderView()
                    .onNext(number)
            }).disposed(by: disposeBag)
        }
    }
    
    private func extractRightBarButtonItem() -> UIBarButtonItem {
        
        guard let rightBarButton = self.navigationItem.rightBarButtonItem
        else {
            return UIBarButtonItem()
        }
        
        return rightBarButton
    }
    
    private func zipStateWithTableViews() -> [String: UITableView] {
        let zip = Dictionary(
            uniqueKeysWithValues: zip([ProgressState.todo.description,ProgressState.doing.description,ProgressState.done.description], self.customView.extractTableViews())
        )
        
        return zip
    }
}

private extension Reactive where Base: UITableView {
    
    func setUpHeaderView() -> Binder<Int> {
        return Binder(self.base) { tableview, Int in
            (tableview.tableHeaderView as! TableViewHeaderUIView).configureCount(Int)
        }
    }
}
