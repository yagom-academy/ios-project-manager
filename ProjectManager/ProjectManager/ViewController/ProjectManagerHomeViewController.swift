//
//  ProjectManager - ProjectManagerHomeViewController.swift
//  Created by Minseong. 
// 

import UIKit

import RealmSwift

final class ProjectManagerHomeViewController: UIViewController {
  @IBOutlet weak var todoCollectionView: UICollectionView!
  @IBOutlet weak var doingCollectionView: UICollectionView!
  @IBOutlet weak var doneCollectionView: UICollectionView!

  private let realmService = RealmService()
  private var projects: Results<Project>?
  private var notificationToken: NotificationToken?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.projects = realmService.read(projectType: Project.self)
    self.initializeNavigationBar()
    self.initializeCollectionView()
    self.reloadDataWhenChangedRealmData()
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.notificationToken?.invalidate()
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

  private func reloadDataWhenChangedRealmData() {
    let realm = try? Realm()

    self.notificationToken = realm?.observe { (_, _) in
      self.todoCollectionView.reloadData()
      self.doingCollectionView.reloadData()
      self.doneCollectionView.reloadData()
    }
  }

  @IBAction func addProjectButton(_ sender: UIBarButtonItem) {
    guard let projectAddVC = storyboard?.instantiateViewController(
      identifier: "\(ProjectAddViewController.self)",
      creator: { coder in ProjectAddViewController(realmService: self.realmService, coder: coder) }
    ) else { return }

    navigationController?.present(projectAddVC, animated: true)
  }
}

// MARK: - UICollectionViewCompositionalLayout

extension ProjectManagerHomeViewController {
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
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    if collectionView == todoCollectionView {
      return fetchItemCount(from: .todo)
    }

    if collectionView == doingCollectionView {
      return fetchItemCount(from: .doing)
    }

    if collectionView == doneCollectionView {
      return fetchItemCount(from: .done)
    }

    return 0
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "projectManagerCell",
      for: indexPath
    ) as? ProjectManagerCollectionViewCell else {
      return UICollectionViewCell()
    }

    if collectionView == todoCollectionView {
      self.allocate(to: cell, projectCategory: .todo, indexPath: indexPath)
    }

    if collectionView == doingCollectionView {
      self.allocate(to: cell, projectCategory: .doing, indexPath: indexPath)
    }

    if collectionView == doneCollectionView {
      self.allocate(to: cell, projectCategory: .done, indexPath: indexPath)
    }

    return cell
  }

  private func fetchItemCount(from projectCategory: ProjectCategory) -> Int {
    let todoList = projects?.filter {
      $0.projectCategory == projectCategory.description
    }
    guard let itemCount = todoList?.count else { return .zero }

    return itemCount
  }

  private func allocate(
    to cell: ProjectManagerCollectionViewCell,
    projectCategory: ProjectCategory,
    indexPath: IndexPath
  ) {
    let todolist = projects?.filter {
      $0.projectCategory == projectCategory.description
    }

    guard let todolist = todolist else { return }

    cell.configure(
      title: todolist[indexPath.row].title,
      body: todolist[indexPath.row].body ?? "",
      date: todolist[indexPath.row].date
    )
  }
}
