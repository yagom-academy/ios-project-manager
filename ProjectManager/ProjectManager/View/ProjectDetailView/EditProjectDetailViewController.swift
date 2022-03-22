import UIKit
import RxSwift
import RxCocoa

protocol ProjectDetailViewControllerDelegate: AnyObject {
    func didUpdateProject(_ project: Project)
    func didAppendProject(_ project: Project)
}

final class EditProjectDetailViewController: ProjectDetailViewController {
    private let disposeBag = DisposeBag()
    private let didTapDoneButtonObservable = PublishSubject<Void>()
    
    private var viewModel: EditProjectDetailViewModel?
    weak var delegate: ProjectDetailViewControllerDelegate?
    
    init(viewModel: EditProjectDetailViewModel, delegate: ProjectDetailViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.delegate = delegate
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    private func populateView(with data: Project?) {
        projectDetailView.populateData(with: data)
    }
    
    private func configureBind() {
        editButtonItem.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.toggleEditMode()
            }).disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem?.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        let input = EditProjectDetailViewModel.Input(didTapDoneButtonObservable: self.didTapDoneButtonObservable.asObservable())
        
        guard let output = viewModel?.transform(input) else {
            return
        }
        
        output
            .updateObservable
            .subscribe(onNext: { [weak self] project in
                self?.delegate?.didUpdateProject(project)
            }).disposed(by: disposeBag)
    }
    
    private func toggleEditMode() {
        if !isEditing {
            projectDetailView.setEditingMode(to: true)
            isEditing = true
        } else {
            projectDetailView.setEditingMode(to: false)
            isEditing = false
            self.updateCurrentProject()
            self.dismiss(animated: true) {
                self.didTapDoneButtonObservable.onNext(())
            }
        }
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
