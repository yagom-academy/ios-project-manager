import UIKit

final class DetailCoordinator: Coordinator {
    enum Constant {
        static let storyboardName = "Detail"
        static let storyboardID = "DetailViewController"
    }
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType = .detail
    
    init(
        _ navigationController: UINavigationController = UINavigationController(),
        parentCoordinator: Coordinator
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start(_ project: Project, useCase: ProjectListUseCase, mode: DetailViewModel.ViewMode) {
        let viewModel = DetailViewModel(
            useCase: useCase,
            coordinator: self,
            project: project,
            mode: mode
        )
        let detailViewController = DetailViewController.createFromStoryboard(viewModel: viewModel)
        detailViewController.modalPresentationStyle = .currentContext
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
        let main = parentCoordinator as? MainCoordinator
        main?.remove(childCoordinator: self)
    }
}
