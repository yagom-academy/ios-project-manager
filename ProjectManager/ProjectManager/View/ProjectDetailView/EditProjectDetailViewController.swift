import UIKit

class EditProjectDetailViewController: ProjectDetailViewController {
    var viewModel: ProjectViewModelProtocol?
    var currentProject: Project?
//    var currentIndex: Int?
    
    init(viewModel: ProjectViewModelProtocol?, currentProject: Project) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.currentProject = currentProject
//        self.currentIndex = currentIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
            self.dismiss(animated: true) { [self] in
                guard let currentProject = currentProject else {
                    return
                }
                let updatedProject = projectDetailView.retrieveViewData(with: currentProject)
                viewModel?.update(with: updatedProject)
            }
        }
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
