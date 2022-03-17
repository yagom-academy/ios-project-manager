import UIKit

protocol ProjectDetailViewControllerDelegate: AnyObject {
    func didUpdateProject(_ project: Project)
    func didAppendProject(_ project: Project)
}

final class EditProjectDetailViewController: ProjectDetailViewController {
    weak var delegate: ProjectDetailViewControllerDelegate?
    var viewModel: EditProjectDetailViewModel?

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
        
        viewModel?.onUpdated = { project in
            self.delegate?.didUpdateProject(project)
        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            projectDetailView.setEditingMode(to: true)
        } else {
            projectDetailView.setEditingMode(to: false)
            self.dismiss(animated: true) {
                self.updateListView()
            }
        }
    }
    
    private func updateListView() {
        guard let currentProject = viewModel?.currentProject else {
            return
        }
        let updatedProject = self.updatedViewData(with: currentProject)
        viewModel?.didTapDoneButton(updatedProject)
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func populateView(with data: Project?) {
        projectDetailView.populateData(with: data)
    }
}

//MARK: - Constants

private extension EditProjectDetailViewController {
    enum TitleText {
        static let navigationBarTitle = "TODO"
    }
}
