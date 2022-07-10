//
//  ProjectManager - ProjectManagerHomeViewController.swift
//  Created by Minseong. 
// 

import UIKit

final class ProjectManagerHomeViewController: UIViewController {
  @IBOutlet weak var todoCollectionView: UICollectionView!
  @IBOutlet weak var doingCollectionView: UICollectionView!
  @IBOutlet weak var doneCollectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.initializeNavigationBar()
  }

  private func initializeNavigationBar() {
    self.navigationItem.title = "Project Manager"
  }
}
