import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let repository: TaskRepository = TaskDataRepository()
        let useCase: TaskUseCase = FetchTaskUseCase(repository: repository)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        let viewController = navigationController?.viewControllers.first as? TaskCollectionViewController
        let viewModel: TaskViewModelable = TaskViewModel(useCase: useCase)
        viewController?.setViewModel(viewModel)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

