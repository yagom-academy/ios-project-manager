//
//  ProjectManager - ProjectManagerHomeViewController.swift
//  Created by Minseong. 
// 

import UIKit

final class ProjectManagerHomeViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initializeNavigationBar()
  }

  private func initializeNavigationBar() {
    self.navigationItem.title = "Project Manager"
  }
}
