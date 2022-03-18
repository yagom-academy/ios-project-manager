import UIKit

final class MainCoordinator: Coordinator {
   
    var navigationController: UINavigationController?
    let repositoryFactory = RepositoryFactory()
    let currentRepository = MockDataRepository()
    lazy var useCase = ProjectManagerUseCase(repository: self.currentRepository)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MainViewController()
        viewController.viewModel = MainViewModel(useCase: self.useCase, coordinator: self)
        self.navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func occuredEvent(with type: Event) {
        let viewController = DetailAddViewController()
        viewController.viewModel = DetailAddViewModel(useCase: self.useCase)
        viewController.viewModel?.coordinator = self
        let detailViewNavigationController = UINavigationController(rootViewController: viewController)
        
        switch type {
        case .presentDetailAddView:
            self.navigationController?.present(detailViewNavigationController, animated: false)
        case .dismissDetailAddView:
            self.navigationController?.dismiss(animated: false)
        }
    }
}


enum Event {
    
    case presentDetailAddView
    case dismissDetailAddView
}
