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
        mode: DetailViewModel.ViewMode
    ) {
        let detailCoordinator = DetailCoordinator()
        detailCoordinator.start(project, useCase: useCase, mode: mode)
        
        navigationController.topViewController?.present(
            detailCoordinator.navigationController,
            animated: true
        )
    }
    
    func showActionSheet(
        sourceView: UIView,
        titles: (String, String),
        topHandler: @escaping (UIAlertAction) -> Void,
        bottomHandler: @escaping (UIAlertAction) -> Void
    ) {
        let topAction = UIAlertAction(title: "Move to \(titles.0)", style: .default, handler: topHandler)
        let bottomAction = UIAlertAction(title: "Move to \(titles.1)", style: .default, handler: bottomHandler)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(topAction)
        alert.addAction(bottomAction)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sourceView
            let rect = CGRect(x: .zero, y: .zero, width: sourceView.bounds.width, height: sourceView.bounds.height / 2)
            popoverController.sourceRect = rect
            popoverController.permittedArrowDirections = [.up, .down]
        }
        navigationController.topViewController?.present(alert, animated: true)
    }
}
