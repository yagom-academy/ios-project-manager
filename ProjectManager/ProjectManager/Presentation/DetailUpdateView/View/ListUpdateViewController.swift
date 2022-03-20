import UIKit
import RxSwift
import RxCocoa

final class ListUpdateViewController: UIViewController {
    
    let shareView = ListDetailUIView()
    var viewModel: ListUpdateViewModel?
    let disposeBag = DisposeBag()
    var navigationRightBarButtonItem: UIBarButtonItem?
    var navigationLeftBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(shareView)
        shareView.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .white
        self.configureNavigationItem()
        self.configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bind()
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
        let input = ListUpdateViewModel.Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in}, doneEdittingEvent: (self.navigationRightBarButtonItem?.rx.tap)!.asObservable(), cancelButtonTapped: (self.navigationLeftBarButtonItem?.rx.tap)!.asObservable())
        
        let output = viewModel?.transform(input: input, disposeBag: self.disposeBag)
        
        output?.selectedProjectData
            .bind(onNext: { list in
                self.shareView.textfield.text = list.name
                self.shareView.textView.text = list.detail
                self.shareView.datePicker.date = list.deadline
            }).disposed(by: self.disposeBag)
        
        self.viewModel?.state
            .filter { $0 == .done }
            .subscribe(onNext: { _ in
                self.viewModel?.inputedData.onNext(self.createObservableInformation())
            }).disposed(by: self.disposeBag)
    }
    
    private func createObservableInformation() -> (name: String, detail: String, deadline: Date) {
        return ((name: self.shareView.textfield.text!, detail: self.shareView.textView.text, deadline: self.shareView.datePicker.date))
        }
}
