import UIKit

final class MainCoordinator: Coordinator {
   
    var navigationController: UINavigationController?
    let currentRepository = RepositoryFactory.createRepository(repository: RepositoryChecker.currentRepository)
    private lazy var controlUseCase = ProjectControlUseCase(repository: self.currentRepository)
    private lazy var historyUseCase = ProjectHistoryCheckUseCase()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ListViewController()
        viewController.viewModel = ListViewModel(controlUseCase: self.controlUseCase, historyCheckUseCase: self.historyUseCase, coordinator: self)
        self.navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func occuredViewEvent(with event: Event.View) {
        let projectAddView = configureProjectAddView()
        
        switch event {
        case .presentListAddView:
            self.navigationController?.present(projectAddView, animated: false)
        case .dismissListAddView:
            self.navigationController?.dismiss(animated: false)
        case .presentListUpdateView(let id):
            let projectUpdateView = configureProjectUpdateView(identifier: id)
            self.navigationController?.present(projectUpdateView, animated: false)
        case .dismissListUpdateView:
            self.navigationController?.dismiss(animated: false)
        }
    }
    
    func occuredRepositoryChangeEvent(with type: Event.NetWork) {
        
    }
    
    private func configureProjectAddView() -> UINavigationController {
        let viewController = ListAddViewController()
        viewController.viewModel = ListAddViewModel(controlUseCase: self.controlUseCase, historyCheckUseCase: self.historyUseCase, coordinator: self)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    private func configureProjectUpdateView(identifier: String) -> UINavigationController {
        let viewController = ListUpdateViewController()
        viewController.viewModel = ListUpdateViewModel(controlUseCase: self.controlUseCase, historyCheckUseCase: self.historyUseCase, identifier: identifier, coordinator: self)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}


enum Event {
    
    enum View {
        
        case presentListAddView
        case dismissListAddView
        case presentListUpdateView(identifier: String)
        case dismissListUpdateView
    }
    
    enum NetWork {
        
    }
}
