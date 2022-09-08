        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let newWindow = UIWindow(windowScene: windowScene)
        newWindow.rootViewController = ProjectManagerViewController()
        newWindow.makeKeyAndVisible()
        self.window = newWindow
