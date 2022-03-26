import UIKit
import RxSwift

protocol ProjectDetailViewControllerDelegate: AnyObject {
    func didUpdateProject(_ project: Project)
    func didAppendProject(_ project: Project)
}

final class EditProjectDetailViewController: ProjectDetailViewController {
    private let disposeBag = DisposeBag()
    var viewModel: EditProjectDetailViewModel?
    
    private let cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: EditProjectDetailViewController.self, action: nil)
        return button
    }()
    
    init(viewModel: EditProjectDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView(with: viewModel?.currentProject)
        configureNavigationBar()
        projectDetailView.setEditingMode(to: false)
    
        configureBind()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = cancelButton
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    private func configureBind() {
        let didTapButtonObservable = editButtonItem.rx.tap
            .do(onNext: { [weak self] in self?.toggleEditMode() })
                .asObservable()
//            .subscribe(onNext: { [weak self] in
//                self?.toggleEditMode()
//            }).disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        let input = EditProjectDetailViewModel.Input(didTapDoneButton: didTapButtonObservable)
        
        _ = viewModel?.transform(input: input)
    }
    
    private func toggleEditMode() {
        if !isEditing {
            projectDetailView.setEditingMode(to: true)
            isEditing = true
        } else {
            projectDetailView.setEditingMode(to: false)
            isEditing = false
            self.updateCurrentProject()
            self.dismiss(animated: true)
        }
    }
    
    private func populateView(with data: Project?) {
        projectDetailView.populateData(with: data)
    }
    
    private func updateCurrentProject() {
        guard let currentProject = viewModel?.currentProject else {
            return
        }
        let updatedProject = self.updatedViewData(with: currentProject)
        viewModel?.currentProject = updatedProject
    }
}

//MARK: - Constants

private extension EditProjectDetailViewController {
    enum TitleText {
        static let navigationBarTitle = "TODO"
    }
}

