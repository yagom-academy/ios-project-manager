//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    
    if let windowSecene = (scene as? UIWindowScene) {
      let contentView = ProjectManagerView()
      window = UIWindow(windowScene: windowSecene)
      window?.rootViewController = UIHostingController(rootView: contentView)
      window?.makeKeyAndVisible()
    }
  }
  
  func sceneDidDisconnect(_ scene: UIScene) { }
  
  func sceneDidBecomeActive(_ scene: UIScene) { }
  
  func sceneWillResignActive(_ scene: UIScene) { }
  
  func sceneWillEnterForeground(_ scene: UIScene) { }
  
  func sceneDidEnterBackground(_ scene: UIScene) { }
}
