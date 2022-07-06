//
//  AppAppearance.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import UIKit

final class AppAppearance {
  static func configureNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithDefaultBackground()
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
}
