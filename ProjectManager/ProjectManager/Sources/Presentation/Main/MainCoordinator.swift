import UIKit
import RxCocoa
import RxSwift

enum ActionType: CaseIterable {
    case top
    case bottom
}

final class MainCoordinator: Coordinator {
    enum Constant {
        static let storyboardName = "Main"
        static let storyboardID = "MainViewController"
        static let actionTitle = "Move to "
    }
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType = .main
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func storyboardStart() {
        let viewModel = ProjectListViewModel(coordinator: self)
        let mainViewController = MainViewController.createFromStoryboard(viewModel: viewModel)
        
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    func presentDetailViewController(
        _ project: Project,
        useCase: ProjectListUseCase,
        mode: DetailViewModel.ViewMode
    ) {
        let detailCoordinator = DetailCoordinator(parentCoordinator: self)
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start(project, useCase: useCase, mode: mode)
        navigationController.topViewController?.present(
            detailCoordinator.navigationController,
            animated: true
        )
    }
    
    func showActionSheet(sourceView: UIView, titles: [String]) -> Observable<ProjectState> {
        return Observable.create { observer in
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            for index in 0..<ActionType.allCases.count {
                let action = UIAlertAction(title: "\(Constant.actionTitle)\(titles[index])", style: .default) { _ in
                    observer.onNext(ProjectState.uppercased(titles[index]))
                    observer.onCompleted()
                }
                alert.addAction(action)
            }
            alert.popoverPresentationController
                .flatMap {
                    $0.sourceView = sourceView
                    let rect = CGRect(
                        x: .zero,
                        y: .zero,
                        width: sourceView.bounds.width,
                        height: sourceView.bounds.height / 2
                    )
                    $0.sourceRect = rect
                    $0.permittedArrowDirections = [.up, .down]
                }
            self.navigationController.topViewController?.present(alert, animated: true)
            
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func remove(childCoordinator: Coordinator) {
        _ = childCoordinators.firstIndex(where: { $0.type == childCoordinator.type})
            .flatMap { childCoordinators.remove(at: $0) }
    }
}
