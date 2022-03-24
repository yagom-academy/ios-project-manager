import UIKit
import RxSwift
import RxCocoa

final class AddProjectDetailViewController: ProjectDetailViewController {
    weak var delegate: ProjectDetailViewControllerDelegate?
    var viewModel: AddProjectDetailViewModel?
    
    private let doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: AddProjectDetailViewController.self, action: nil)
        return button
    }()
    
    private let cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: AddProjectDetailViewController.self, action: nil)
        return button
    }()
    
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
        bind()
//        viewModel?.onAppended = { project in
//            self.delegate?.didAppendProject(project)
//        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    func bind() {
        let input = AddProjectDetailViewModel.Input(didTapdoneButton: doneButton.rx.tap.asObservable(),
                                                    projectTitle: projectDetailView.titleTextField.rx.text.orEmpty.asObservable(),
                                                    projectBody: projectDetailView.bodyTextView.rx.text.orEmpty.asObservable(),
                                                    projectDate: projectDetailView.datePicker.rx.date.asObservable())
        
        let output = viewModel?.transform(input: input)
    }
//
//    @objc private func didTapDoneButton() {
//        self.dismiss(animated: true) {
//            let project = self.createViewData()
//            self.viewModel?.didTapDoneButton(project)
//        }
//    }
//
//    @objc private func didTapCancelButton() {
//        self.dismiss(animated: true, completion: nil)
//    }
}

//MARK: - Constants

private extension AddProjectDetailViewController {
    enum TitleText {
        static let navigationBarTitle = "TODO"
    }
}
