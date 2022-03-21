import UIKit
import RxSwift
import RxCocoa

final class ListViewController: UIViewController {
    
    // MARK: - properties
    var viewModel: ListViewModel?
    private let disposeBag = DisposeBag()
    private var shareView = MainListUIView()

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
        let tableviews = zipStateWithTableViews().values
        tableviews.forEach { tableview in
            tableview.addGestureRecognizer(longPressGesture)
        }
    }
    
    @objc
    func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        zipStateWithTableViews().values.forEach { tableview in
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: tableview)
            if tableview.indexPathForRow(at: touchPoint) != nil {
                
            }
          }
       }
    }

    private func configureMainView() {
        view.addSubview(shareView)
        view.backgroundColor = .white
        self.shareView.translatesAutoresizingMaskIntoConstraints = false
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
            self.shareView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.shareView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.shareView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.shareView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: - bind UI w/ RxSwift 
    private func configureInput() -> ListViewModel.Input {
        let tableViews = shareView.extractTableViews()
        let rightBarButton = self.extractRightBarButtonItem()
        let input = ListViewModel
            .Input(
                viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in },
                projectAddButtonTapped: rightBarButton.rx.tap.asObservable(), projectDeleteEvent:
                    tableViews.map{ $0.rx.modelDeleted(Project.self).map { $0.identifier }}, projectDidtappedEvent: tableViews.map{ $0.rx.modelSelected(Project.self).map { $0.identifier } }
            )
        
        return input
    }
        
    private func configureOutput(input: ListViewModel.Input) {
        let output = self.viewModel?.transform(input: input, disposeBag: self.disposeBag)
        let stateWithTableViews = self.zipStateWithTableViews()
        stateWithTableViews.forEach { zip in
            output?.baseProjects.map({ lists in
                lists.filter { $0.progressState.description == zip.key }
            })
            .asDriver(onErrorJustReturn: [])
            .drive(zip.value.rx.items(cellIdentifier: String(describing: ListUITableViewCell.self), cellType: ListUITableViewCell.self)) { index, item , cell in
                cell.configureCellUI(data: item)
            }.disposed(by: disposeBag)
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
            uniqueKeysWithValues: zip([ProgressState.todo.description,ProgressState.doing.description,ProgressState.done.description], self.shareView.extractTableViews())
        )
        
        return zip
    }
}

