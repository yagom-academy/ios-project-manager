import UIKit
import RxSwift

class EditProjectViewController: UIViewController {
    private let editView = ProjectFormView()
    private let viewModel: EditProjectViewModel
    
    private let tapEditProjectObserver: PublishSubject<ProjectInput> = .init()
    private let tapCancelButtonObserver: PublishSubject<Void> = .init()
    private let disposeBag: DisposeBag = .init()
    
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
    
    init(viewModel: EditProjectViewModel) {
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
    
    func setupEditView(with project: Project) {
        navigationTitle.text = project.state.title
        editView.setupFormView(with: project)
    }
    
    private func bind() {
        let input = EditProjectViewModel.Input(tapEditProjectObserver: tapEditProjectObserver.asObservable(), tapCancelButtonObserver: tapCancelButtonObserver.asObservable())
        
        let output = viewModel.transform(input)
        
        output.viewDismissObserver
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
                self?.actionAfterDismiss()
            })
            .disposed(by: disposeBag)
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
        tapCancelButtonObserver.onNext(())
    }
    
    @objc private func saveEditedProject() {
        let projectInput = (editView.title, editView.body, editView.date)
        tapEditProjectObserver.onNext(projectInput)
    }
}
