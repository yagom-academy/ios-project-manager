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
    
    func presentDetailViewController(_ project: Project, useCase: ProjectListUseCase, mode: DetailViewModel.DetailViewMode) {
        let storyboard = UIStoryboard(name: "Detail", bundle: .main)
        guard let nextVC = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController"
        ) as? UINavigationController,
              let detail = nextVC.topViewController as? DetailViewController else {
            return
        }
        detail.viewModel = DetailViewModel(useCase: useCase, project: project, mode: mode)
        
        navigationController.topViewController?.present(nextVC, animated: true, completion: nil)
        
    }
}
