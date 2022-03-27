import UIKit
import RxSwift

class AddProjectViewController: UIViewController {
    private let addView = ProjectFormView()
    private let viewModel: AddProjectViewModel
    
    private let tapAddProjectObserver: PublishSubject<ProjectInput> = .init()
    private let tapCancelButtonObserver: PublishSubject<Void> = .init()
    private let disposeBag: DisposeBag = .init()
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationBar
    }()
    
    init(viewModel: AddProjectViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNavigationBarLayout()
        setupAddFormViewLayout()
    }
    
    private func bind() {
        let input = AddProjectViewModel.Input(tapAddProjectObserver: tapAddProjectObserver.asObservable(), tapCancelButtonObserver: tapCancelButtonObserver.asObservable())
        
        let output = viewModel.transform(input)
        
        output.viewDismissObserver
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        let navigationItem = UINavigationItem(title: ProjectState.todo.title)
        let cancleItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addProject))
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
        tapCancelButtonObserver.onNext(())
    }
    
    @objc private func addProject() {
        let projectInput: ProjectInput = (addView.title, addView.body, addView.date)
        tapAddProjectObserver.onNext(projectInput)
    }
}
