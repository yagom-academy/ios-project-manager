import UIKit
import RxSwift
import RxCocoa

final class ListUpdateViewController: UIViewController {

    var viewModel: ListUpdateViewModel?
    private let shareView = ListDetailUIView()
    private let disposeBag = DisposeBag()
    private var navigationRightBarButtonItem: UIBarButtonItem?
    private var navigationLeftBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureNavigationItem()
        self.configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bind()
    }
    
    private func configureView() {
        self.view.addSubview(shareView)
        self.shareView.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .white
    }
    
    private func configureNavigationItem() {
        self.navigationItem.title = "TODO"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        self.navigationLeftBarButtonItem = self.navigationItem.leftBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: nil)
        self.navigationRightBarButtonItem = self.navigationItem.rightBarButtonItem
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.shareView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.shareView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.shareView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.shareView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
  
    private func bind() {
        guard let rightTapEvent = self.navigationRightBarButtonItem?.rx.tap, let leftTapEvent = self.navigationLeftBarButtonItem?.rx.tap
        else {
            return
        }
        
        let tap = rightTapEvent.asObservable()
        let data = Observable<(name: String, detail: String, deadline: Date)>.create { emitter in
            _ = tap.subscribe { _ in
                emitter.onNext(self.createObservableInformation())
            }
            return Disposables.create {
                
            }
        }
        
        let k = tap.withLatestFrom(data)
        
        let input = ListUpdateViewModel.Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in}, doneEdittingEvent: rightTapEvent.asObservable(), cancelButtonTapped: leftTapEvent.asObservable(), inputedData: k)
        
        let output = viewModel?.transform(input: input, disposeBag: self.disposeBag)
        
        output?.selectedProjectData
            .bind(onNext: { list in
                self.shareView.configureUIComponents(name: list.name, detail: list.detail, deadline: list.deadline)
            }).disposed(by: self.disposeBag)

    }
    
    private func createObservableInformation() -> (name: String, detail: String, deadline: Date) {
        return self.shareView.extractComponentsData()
        }
}
