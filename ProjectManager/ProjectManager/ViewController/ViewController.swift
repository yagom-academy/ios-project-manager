//
//  ProjectManager - ViewController.swift
//  Created by Minseong. 
// 

import UIKit

final class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initializeNavigationBar()
  }

  private func initializeNavigationBar() {
    self.navigationItem.title = "Project Manager"
  }
}
