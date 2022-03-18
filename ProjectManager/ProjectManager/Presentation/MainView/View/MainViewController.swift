import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    // MARK: - properties
    var viewModel: MainViewModel?
    private var shareView = MainUIView()
    let disposeBag = DisposeBag()
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMainView()
        self.configureLayout()
        self.configureNavigationItems()
        self.bind()
    }
  // MARK: - methods
    private func configureMainView() {
        view.addSubview(shareView)
        view.backgroundColor = .white
        shareView.translatesAutoresizingMaskIntoConstraints = false
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
            shareView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            shareView.trailingAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            shareView.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            shareView.bottomAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    // MARK: - bind UI w/ RxSwift 
    private func bind() {
        
        guard let rightBarButton = self.navigationItem.rightBarButtonItem
        else {
            return
        }
        
        let input = MainViewModel
            .Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in },
                   addActionTappedEvent: rightBarButton.rx.tap.asObservable()
            )
        
        let output = viewModel?.transform(input: input, disposeBag: self.disposeBag)
  
        output?.intialListables
            .asDriver(onErrorJustReturn: [])
            .drive(shareView.todoTableView.rx.items(cellIdentifier: String(describing: ProjectUITableViewCell.self), cellType: ProjectUITableViewCell.self)) { index, item , cell in
                cell.configureCellUI(data: item)
            }.disposed(by: disposeBag)
}

}

