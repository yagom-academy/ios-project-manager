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
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemBackground
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
}
