import UIKit
import RxSwift
import RxCocoa

class DetailAddViewController: UIViewController {
    
    private let shareView = ProjectDetailUIView()
    var viewModel: DetailAddViewModel?
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = shareView
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
        let input = DetailAddViewModel.Input(cancelButtonTappedEvent: (self.navigationItem.leftBarButtonItem?.rx.tap.asObservable())!, doneButtonTappedEvent: (self.navigationItem.rightBarButtonItem?.rx.tap.asObservable())!)
        viewModel?.transform(input: input, disposeBag: self.disposeBag)
        
        viewModel?.state
            .filter { $0 == .done }
            .subscribe { _ in
            self.viewModel?.observableData.onNext(self.createObservableInformation())
        }.disposed(by: disposeBag)
    }
    
    private func createObservableInformation() -> (name: String, detail: String, deadline: Date) {
        return ((name: self.shareView.textfield.text!, detail: self.shareView.textView.text, deadline: self.shareView.datePicker.date))
        }
}
