import UIKit
import RxSwift
import RxCocoa

final class AddProjectDetailViewController: ProjectDetailViewController {
    weak var delegate: ProjectDetailViewControllerDelegate?
    var viewModel: AddProjectDetailViewModel?
    private let disposeBag = DisposeBag()
    
    
    private let doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: AddProjectDetailViewController.self, action: nil)
        return button
    }()
    
    private let cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: AddProjectDetailViewController.self, action: nil)
        return button
    }()
    
    init(viewModel: AddProjectDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        cofigureBind()
        cofigureNavigationItemBind()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    func cofigureBind() {
        let input = AddProjectDetailViewModel.Input(didTapdoneButton: doneButton.rx.tap.asObservable(),
                                                    projectTitle: projectDetailView.titleTextField.rx.text.orEmpty.asObservable(),
                                                    projectBody: projectDetailView.bodyTextView.rx.text.orEmpty.asObservable(),
                                                    projectDate: projectDetailView.datePicker.rx.date.asObservable())
        
        _ = viewModel?.transform(input: input)
    }
    
    func cofigureNavigationItemBind() {
        doneButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
}

//MARK: - Constants

private extension AddProjectDetailViewController {
    enum TitleText {
        static let navigationBarTitle = "TODO"
    }
}
