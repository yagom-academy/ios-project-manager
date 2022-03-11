import UIKit

class AddProjectDetailViewController: ProjectDetailViewController {
    var viewModel: ProjectViewModelProtocol?
    
    init(viewModel: ProjectViewModelProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    @objc private func didTapDoneButton() {
        self.dismiss(animated: true) {
            let project = self.projectDetailView.createViewData()
            self.viewModel?.create(with: project)
        }
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Constants

private extension AddProjectDetailViewController {
    enum TitleText {
        static let navigationBarTitle = "TODO"
    }
}
