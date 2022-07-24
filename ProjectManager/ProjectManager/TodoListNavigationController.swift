//
//  TodoListNavigationController.swift
//  ProjectManager
//
//  Created by song on 2022/07/24.
//

import UIKit

class ExpoNavigationController: UINavigationController {
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    attribute()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return self.topViewController?.supportedInterfaceOrientations ?? .all
  }
  
  private func attribute() {
    let navigationAppearance = UINavigationBarAppearance()
    navigationAppearance.backgroundColor = .red
    navigationBar.standardAppearance = navigationAppearance
    navigationBar.compactAppearance = navigationAppearance
    navigationBar.scrollEdgeAppearance = navigationAppearance
  }
}
