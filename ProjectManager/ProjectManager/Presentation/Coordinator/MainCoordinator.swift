import UIKit

final class MainCoordinator: Coordinator {
   
    var navigationController: UINavigationController?
    let currentRepository = RepositoryFactory.assignRepository(repository: RepositoryChecker.currentRepository)
    lazy var controlUseCase = ProjectControlUseCase(repository: self.currentRepository)
    lazy var historyUseCase = ProjectHistoryCheckUseCase()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MainViewController()
        viewController.viewModel = MainViewModel(useCase: self.controlUseCase, coordinator: self)
        self.navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func occuredViewEvent(with type: Event.View) {
        let projectAddView = configureProjectAddView()
        
        switch type {
        case .presentProjectAddView:
            self.navigationController?.present(projectAddView, animated: false)
        case .dismissProjectAddView:
            self.navigationController?.dismiss(animated: false)
        case .presentProjectUpdateView(let id):
            let projectUpdateView = configureProjectUpdateView(identifier: id)
            self.navigationController?.present(projectUpdateView, animated: false)
        case .dismissProjectUpdateView:
            self.navigationController?.dismiss(animated: false)
        }
    }
    
    func occuredRepositoryChangeEvent(with type: Event.NetWork) {
        
    }
    
    private func configureProjectAddView() -> UINavigationController {
        let viewController = DetailAddViewController()
        viewController.viewModel = DetailAddViewModel(useCase: self.controlUseCase)
        viewController.viewModel?.coordinator = self
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    private func configureProjectUpdateView(identifier: String) -> UINavigationController {
        let viewController = DetailUpdateViewController()
        viewController.viewModel = DetailUpdateViewModel(controlUseCase: self.controlUseCase, historyCheckUseCase: self.historyUseCase, identifier: identifier)
        viewController.viewModel?.coordinator = self
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}


enum Event {
    
    enum View {
        
        case presentProjectAddView
        case dismissProjectAddView
        case presentProjectUpdateView(identifier: String)
        case dismissProjectUpdateView
    }
    
    enum NetWork {
        
    }
}
