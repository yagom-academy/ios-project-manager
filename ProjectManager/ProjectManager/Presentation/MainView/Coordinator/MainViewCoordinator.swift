import UIKit

final class MainViewCoordinator { // 디테일, 수정
    
    let navigationController: UINavigationController
    let viewController: MainViewController
    let repositoryFactory = RepositoryFactory()
    
    init(navigationController: UINavigationController, viewController: MainViewController) {
        self.navigationController = navigationController
        self.viewController = viewController
    }

    func start() {
        
        guard let repository = try? repositoryFactory.assignRepository(repository: .coreData)
        else {
            return
        }

        viewController.viewModel = MainViewModel(useCase: ProjectManagerUseCase(repository: repository))
    }
    
//    private func presentDetailAddView(presenter: UIViewController) {
//        let coordinator = DetailAddViewtCoordinator()
//        coordinator.start(presenter: presenter)
//    }
    // …
}
