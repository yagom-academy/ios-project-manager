import UIKit

class AddProjectViewController: UIViewController {
    private let addView = ProjectFormView()
    
    private let navigationBar: UINavigationBar = {
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
        let cancleItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = cancleItem
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
        view.addSubview(addView)
        addView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            addView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor ),
            addView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            addView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
}
