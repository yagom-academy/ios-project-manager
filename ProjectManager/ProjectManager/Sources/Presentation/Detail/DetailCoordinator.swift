import UIKit

final class DetailCoordinator: Coordinator {
    var parentCoordinateor: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType = .datil
    
    init(
        _ navigationController: UINavigationController = UINavigationController(),
        parentCoordinateor: Coordinator
    ) {
        self.navigationController = navigationController
        self.parentCoordinateor = parentCoordinateor
    }
    
    func start(_ project: Project, useCase: ProjectListUseCase, mode: DetailViewModel.ViewMode) {
        let storyboard = UIStoryboard(name: "Detail", bundle: .main)
        guard let detailViewController = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController"
        ) as? DetailViewController else {
            return
        }
        detailViewController.viewModel = DetailViewModel(
            useCase: useCase,
            coordinator: self,
            project: project,
            mode: mode
        )
        detailViewController.modalPresentationStyle = .currentContext
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
        let main = parentCoordinateor as? MainCoordinator
        main?.remove(childCoordinator: self)
    }
}
