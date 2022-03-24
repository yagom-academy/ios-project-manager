import UIKit

class EditProjectViewController: UIViewController {
    private let editView = ProjectFormView()
    weak var viewModel: MainViewModel?
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationBar
    }()
    
    private let navigationTitle: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        
        return label
    }()

    var actionAfterDismiss = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNavigationBarLayout()
        setupAddFormViewLayout()
    }
    
    func setupEditView(with project: Project) {
        navigationTitle.text = project.state.title
        editView.setupFormView(with: project)
    }
    
    private func setupNavigationBar() {
        let navigationItem = UINavigationItem()
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(saveEditedProject))
        navigationItem.titleView = navigationTitle
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = editItem
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    private func setupNavigationBarLayout() {
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setupAddFormViewLayout() {
        view.addSubview(editView)
        editView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            editView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor ),
            editView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            editView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    @objc private func dismissView() {
        dismiss(animated: true)
        actionAfterDismiss()
    }
    
    @objc private func saveEditedProject() {
        viewModel?.editProject(title: editView.title, body: editView.body, date: editView.date)
        dismiss(animated: true)
    }
}
