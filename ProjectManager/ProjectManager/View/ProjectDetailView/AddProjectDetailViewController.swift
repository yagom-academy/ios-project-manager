import UIKit
import RxSwift

final class AddProjectDetailViewController: ProjectDetailViewController {
    private let disposeBag = DisposeBag()
    private let didTapDoneButtonObservable = PublishSubject<Project>()
    
    weak var delegate: ProjectDetailViewControllerDelegate?
    private var viewModel: AddProjectDetailViewModel?
    
    init(viewModel: AddProjectDetailViewModel, delegate: ProjectDetailViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureBind()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    private func configureBind() {
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let project = self?.createViewData() else {
                    return
                }
                
                self?.dismiss(animated: true, completion: {
                    self?.didTapDoneButtonObservable.onNext(project)
                })
            }).disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .subscribe(onNext:{
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        let input = AddProjectDetailViewModel.Input(didTapDoneButtonObservable: self.didTapDoneButtonObservable.asObservable())
        
        guard let output = viewModel?.transform(input) else {
            return
        }
        
        output
            .appendObservable
            .subscribe(onNext: { [weak self] project in
                self?.delegate?.didAppendProject(project)
            }).disposed(by: disposeBag)
    }
}

//MARK: - Constants

private extension AddProjectDetailViewController {
    enum TitleText {
        static let navigationBarTitle = "TODO"
    }
}
