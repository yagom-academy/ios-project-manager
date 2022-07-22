//
//  ProjectManager - ProjectManagerHomeViewController.swift
//  Created by Minseong. 
// 

import UIKit

import RealmSwift

final class ProjectManagerHomeViewController: UIViewController {
  @IBOutlet private weak var todoCollectionView: UICollectionView!
  @IBOutlet private weak var doingCollectionView: UICollectionView!
  @IBOutlet private weak var doneCollectionView: UICollectionView!

  private let realmService = RealmService()
  private var projects: Results<Project>?
  private var notificationToken: NotificationToken?
  private var projectCategory: [UICollectionView: ProjectCategory]?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.projects = realmService.readAll(projectType: Project.self)
    self.initializeNavigationBar()
    self.initializeCollectionView()
    self.realmService.reloadDataWhenChangedRealmData(
      [todoCollectionView, doingCollectionView, doneCollectionView]
    )
    self.projectCategory = [
      self.todoCollectionView: .todo,
      self.doingCollectionView: .doing,
      self.doneCollectionView: .done
    ]
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.realmService.invalidateNotificationToken()
  }

  private func initializeNavigationBar() {
    self.navigationItem.title = "Project Manager"
  }

  private func initializeCollectionView() {
    self.todoCollectionView.dataSource = self
    self.doingCollectionView.dataSource = self
    self.doneCollectionView.dataSource = self
    self.todoCollectionView.delegate = self
    self.doingCollectionView.delegate = self
    self.doneCollectionView.delegate = self
    self.todoCollectionView.collectionViewLayout = listCompositionLayout()
    self.doingCollectionView.collectionViewLayout = listCompositionLayout()
    self.doneCollectionView.collectionViewLayout = listCompositionLayout()
  }

  @IBAction func addProjectButton(_ sender: UIBarButtonItem) {
    guard let projectAddVC = storyboard?.instantiateViewController(
      identifier: "\(ProjectAddViewController.self)",
      creator: { coder in ProjectAddViewController(realmService: self.realmService, coder: coder) }
    ) else { return }

    self.present(projectAddVC, animated: true)
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
    guard let proejctCategory = self.fetchProejctCategory(from: collectionView) else { return .zero }

    return fetchItemCount(from: proejctCategory)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "\(ProjectManagerCollectionViewCell.self)",
      for: indexPath
    ) as? ProjectManagerCollectionViewCell else {
      return UICollectionViewCell()
    }
    guard let projectCategory = fetchProejctCategory(from: collectionView) else { return cell }
    guard let todolist = realmService.filter(projectCategory: projectCategory) else { return cell }

    cell.configure(
      title: todolist[indexPath.row].title,
      body: todolist[indexPath.row].body ?? "",
      date: todolist[indexPath.row].date
    )

    return cell
  }

  private func fetchProejctCategory(from collectionView: UICollectionView) -> ProjectCategory? {
    let projectCategory = projectCategory?[collectionView]

    return projectCategory
  }

  private func fetchItemCount(from projectCategory: ProjectCategory) -> Int {
    let todoList = projects?.filter {
      $0.projectCategory == projectCategory.description
    }
    guard let itemCount = todoList?.count else { return .zero }

    return itemCount
  }
}

// MARK: - UICollectionViewDelegate

extension ProjectManagerHomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let projectCategory = fetchProejctCategory(from: collectionView) else { return }

    self.presentProjectEditView(projectCategory: projectCategory, indexPath: indexPath)
  }

  private func presentProjectEditView(projectCategory: ProjectCategory, indexPath: IndexPath) {
    guard let todolist = realmService.filter(projectCategory: projectCategory) else { return }
    guard let projectAddViewController = storyboard?.instantiateViewController(
      identifier: "\(ProjectAddViewController.self)",
      creator: { coder in ProjectAddViewController(
        realmService: self.realmService,
        uuid: todolist[indexPath.row].uuid,
        coder: coder
      ) }
    ) else { return }

    navigationController?.present(projectAddViewController, animated: true)
  }
}
