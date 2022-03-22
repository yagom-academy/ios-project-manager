import UIKit
import RxSwift
import RxCocoa

final class ListAddViewController: UIViewController {
    
    private let shareView = ListDetailUIView()
    var viewModel: ListAddViewModel?
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = shareView
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItem()
        self.bind()
    }
    
    private func configureNavigationItem() {
        self.navigationItem.title = "TODO"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
    }
    
    private func bind() {
        let input = ListAddViewModel.Input(cancelButtonTappedEvent: (self.navigationItem.leftBarButtonItem?.rx.tap.asObservable())!, doneButtonTappedEvent: (self.navigationItem.rightBarButtonItem?.rx.tap.asObservable())!)
        self.viewModel?.transform(input: input, disposeBag: self.disposeBag)
        
        self.viewModel?.state 
            .filter { $0 == .done }
            .subscribe { _ in
            self.viewModel?.inputedData.onNext(self.createObservableInformation())
        }.disposed(by: disposeBag)
    }
    
    private func createObservableInformation() -> (name: String, detail: String, deadline: Date) {
        return self.shareView.extractComponentsData()
        }
}
