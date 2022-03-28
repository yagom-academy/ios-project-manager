import UIKit


private enum UIName {
    
    static let mainStoryboard = "Main"
    
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let rootStoryboard = UIStoryboard(name: UIName.mainStoryboard, bundle: nil)
        let rootViewController = rootStoryboard.instantiateViewController(
            withIdentifier: String(describing: ProjectViewController.self)
        )
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
}
