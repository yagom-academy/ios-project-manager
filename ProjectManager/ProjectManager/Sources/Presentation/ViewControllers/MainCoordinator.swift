import UIKit

final class MainCoordinator {
    let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let main = storyboard.instantiateViewController(
            withIdentifier: "MainViewController"
        ) as? MainViewController else {
            return
        }
        main.viewModel = ProjectListViewModel(coordinator: self)
        navigationController.pushViewController(main, animated: false)
    }
    
    func presentDetailViewController(
        _ project: Project,
        useCase: ProjectListUseCase,
        mode: DetailViewModel.DetailViewMode
    ) {
        let detailCoordinator = DetailCoordinator()
        detailCoordinator.start(project, useCase: useCase, mode: mode)
        
        navigationController.topViewController?.present(
            detailCoordinator.navigationController,
            animated: true
        )
    }
}
