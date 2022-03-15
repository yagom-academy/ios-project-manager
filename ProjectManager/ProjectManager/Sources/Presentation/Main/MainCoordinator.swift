import UIKit
import RxCocoa
import RxSwift

enum ActionType: CaseIterable {
    case top
    case bottom
}

final class MainCoordinator {
    private let navigationController: UINavigationController
    
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
    
    func showActionSheet(sourceView: UIView, titles: [String]) -> Observable<ProjectState> {
        return Observable.create { observer in
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            for index in 0..<ActionType.allCases.count {
                let action = UIAlertAction(title: "Move to \(titles[index])", style: .default) { _ in
                    observer.onNext(ProjectState(rawValue: titles[index]) ?? ProjectState.todo)
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
}
