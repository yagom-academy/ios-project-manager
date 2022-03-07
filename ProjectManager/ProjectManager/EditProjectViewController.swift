import UIKit

class EditProjectViewController: UIViewController {
    private let editView = ProjectFormView()
    
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNavigationBarLayout()
        setupAddFormViewLayout()
    }
    
    private func setupNavigationBar() {
        let navigationItem = UINavigationItem(title: "TODO")
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = editItem
        navigationItem.rightBarButtonItem = doneItem
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
    }
}
