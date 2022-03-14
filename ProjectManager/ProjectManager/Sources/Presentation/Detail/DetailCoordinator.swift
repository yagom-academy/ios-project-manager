import UIKit

final class DetailCoordinator {
    let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
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
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
