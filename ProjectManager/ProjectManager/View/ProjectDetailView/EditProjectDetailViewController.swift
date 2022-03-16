import UIKit

final class EditProjectDetailViewController: ProjectDetailViewController {
    var viewModel: ProjectViewModelProtocol?
    var currentProject: Project?

    init(viewModel: ProjectViewModelProtocol, currentProject: Project) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.currentProject = currentProject
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView(with: currentProject)
        configureNavigationBar()
        projectDetailView.setEditingMode(to: false)
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
        guard let currentProject = currentProject else {
            return
        }
        let updatedProject = self.updatedViewData(with: currentProject)
        viewModel?.update(updatedProject, state: nil)
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
