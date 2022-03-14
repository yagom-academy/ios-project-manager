import UIKit

final class MainCoordinator: Coordinator {
   
    var navigationController: UINavigationController?
    let repositoryFactory = RepositoryFactory()
    let currentRepository = MockDataRepository()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MainViewController()
        viewController.viewModel = MainViewModel(useCase: ProjectManagerUseCase(repository: currentRepository), coordinator: self)
        navigationController?.setViewControllers([viewController], animated: false)

    }
    
    func occuredEvent(with type: Event) {
        switch type {
        case .buttonTapped:
            let viewController = DetailAddViewController()
            viewController.viewModel = DetailAddViewModel(useCase: ProjectManagerUseCase(repository: currentRepository))
            viewController.viewModel?.coordinator = self
            let navigationController = UINavigationController(rootViewController: viewController)
            self.navigationController?.present(navigationController, animated: false)
        }
    }
}


enum Event {
    case buttonTapped
}
