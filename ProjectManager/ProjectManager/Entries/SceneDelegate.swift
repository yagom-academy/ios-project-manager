import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var repository: TaskRepository { TaskDataRepository() }

    private var useCase: TaskUseCase { FetchTaskUseCase(repository: repository) }

    private var viewModel: TaskViewModelable { TaskViewModel(useCase: useCase) }

    private var navigationController: UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        let viewController = navigationController?.viewControllers.first as? TaskCollectionViewController
        viewController?.setViewModel(viewModel)
        return navigationController ?? UINavigationController()
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureWindow(scene: windowScene)
    }

    private func configureWindow(scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

