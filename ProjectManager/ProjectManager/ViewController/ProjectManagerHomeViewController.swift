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
    self.initializeCollectionView()
  }

  private func initializeNavigationBar() {
    self.navigationItem.title = "Project Manager"
  }

  private func initializeCollectionView() {
    self.todoCollectionView.dataSource = self
    self.doingCollectionView.dataSource = self
    self.doneCollectionView.dataSource = self
    self.todoCollectionView.collectionViewLayout = listCompositionLayout()
    self.doingCollectionView.collectionViewLayout = listCompositionLayout()
    self.doneCollectionView.collectionViewLayout = listCompositionLayout()
  }

  private func listCompositionLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(
       widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
       heightDimension: NSCollectionLayoutDimension.estimated(1)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
    section.interGroupSpacing = 10

    let layout = UICollectionViewCompositionalLayout(section: section)

    return layout
  }
}

// MARK: - UICollectionViewDataSource

extension ProjectManagerHomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "projectManagerCell",
      for: indexPath
    ) as? ProjectManagerCollectionViewCell else {
      return UICollectionViewCell()
    }

    return cell
  }
}
