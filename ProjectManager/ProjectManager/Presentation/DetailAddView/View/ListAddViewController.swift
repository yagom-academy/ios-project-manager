import UIKit
import RxSwift
import RxCocoa

final class ListAddViewController: UIViewController {

    var viewModel: ListAddViewModel?
    private let shareView = ListDetailUIView()
    private let disposeBag = DisposeBag()
    private var navigationRightBarButton: UIBarButtonItem?
    private var navigationLeftBarButton: UIBarButtonItem?
    
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
        self.navigationRightBarButton = self.navigationItem.rightBarButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        self.navigationLeftBarButton = self.navigationItem.leftBarButtonItem
    }
    
    private func bind() {
        guard let rightTapEvent = self.navigationRightBarButton?.rx.tap,
              let leftTapEvent = self.navigationLeftBarButton?.rx.tap
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
        
        let input = ListAddViewModel.Input(cancelButtonTappedEvent: leftTapEvent.asObservable(), doneButtonTappedEvent: rightTapEvent.asObservable(), inputedData: data)
        self.viewModel?.transform(input: input, disposeBag: self.disposeBag)
    }
    
    private func createObservableInformation() -> (name: String, detail: String, deadline: Date) {
        return self.shareView.extractComponentsData()
        }
}
