import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Property
    var window: UIWindow?

    // MARK: - Method
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let rootStoryboard = UIStoryboard(name: StoryBoard.main.name, bundle: nil)
        let rootViewController = rootStoryboard.instantiateViewController(
            withIdentifier: String(describing: ProjectViewController.self)
        )
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
}
