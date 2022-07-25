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
  @IBOutlet private weak var todoCountLabel: UILabel!
  @IBOutlet private weak var doingCountLabel: UILabel!
  @IBOutlet private weak var doneCountLabel: UILabel!

  private let realmService = RealmService()
  private var projects: Results<Project>?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.projects = realmService.readAll(projectType: Project.self)
    self.initializeNavigationBar()
    self.initializeCollectionView()
    self.setCountLabelCornerRadius()
    self.realmService.reloadDataWhenChangedRealmData(
      [todoCollectionView, doingCollectionView, doneCollectionView]
    )
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.realmService.invalidateNotificationToken()
  }

  private func initializeNavigationBar() {
    self.navigationItem.title = "Project Manager"
  }

  private func initializeCollectionView() {
    [todoCollectionView, doingCollectionView, doneCollectionView].forEach {
      $0?.dataSource = self
      $0?.delegate = self
      $0?.collectionViewLayout = listCompositionLayout()
    }
  }

  private func setCountLabelCornerRadius() {
    [todoCountLabel, doingCountLabel, doneCountLabel].forEach {
      $0?.layer.cornerRadius = 12
      $0?.layer.masksToBounds = true
    }
  }

  @IBAction private func addProjectButton(_ sender: UIBarButtonItem) {
    guard let projectAddVC = storyboard?.instantiateViewController(
      identifier: "\(ProjectAddViewController.self)",
      creator: { coder in ProjectAddViewController(realmService: self.realmService, coder: coder) }
    ) else { return }

    self.present(projectAddVC, animated: true)
  }

  @IBAction private func longPressTodoCollectionView(_ sender: UILongPressGestureRecognizer) {
    self.handleLongPress(todoCollectionView, projectCategory: .todo, gestureRecognizer: sender)
  }

  @IBAction private func longPressDoingCollectionView(_ sender: UILongPressGestureRecognizer) {
    self.handleLongPress(doingCollectionView, projectCategory: .doing, gestureRecognizer: sender)
  }

  @IBAction private func longPressDoneCollectionView(_ sender: UILongPressGestureRecognizer) {
    self.handleLongPress(doneCollectionView, projectCategory: .done, gestureRecognizer: sender)
  }
}

// MARK: - UICollectionViewCompositionalLayout

extension ProjectManagerHomeViewController {
  private func listCompositionLayout() -> UICollectionViewCompositionalLayout {
    let listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
    let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)

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
    let itemCount = fetchItemCount(from: proejctCategory)

    self.configureCountLabel(projectCategory: proejctCategory, itemCount: itemCount)

    return itemCount
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
    guard let projectList = realmService.filter(projectCategory: projectCategory) else { return cell }

    cell.configure(
      title: projectList[indexPath.row].title,
      body: projectList[indexPath.row].body ?? "",
      date: projectList[indexPath.row].date
    )

    return cell
  }

  private func fetchProejctCategory(from collectionView: UICollectionView) -> ProjectCategory? {
    let projectCategory: [UICollectionView: ProjectCategory] = [
      self.todoCollectionView: .todo,
      self.doingCollectionView: .doing,
      self.doneCollectionView: .done
    ]

    return projectCategory[collectionView]
  }

  private func fetchItemCount(from projectCategory: ProjectCategory) -> Int {
    guard let projectList = realmService.filter(projectCategory: projectCategory) else { return .zero}

    return projectList.count
  }

  private func configureCountLabel(projectCategory: ProjectCategory, itemCount: Int) {
    switch projectCategory {
    case .todo:
      self.todoCountLabel.text = "\(itemCount)"
    case .doing:
      self.doingCountLabel.text = "\(itemCount)"
    case .done:
      self.doneCountLabel.text = "\(itemCount)"
    }
  }
}

// MARK: - UICollectionViewDelegate

extension ProjectManagerHomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let projectCategory = fetchProejctCategory(from: collectionView) else { return }

    self.presentProjectEditView(projectCategory: projectCategory, indexPath: indexPath)
  }

  private func presentProjectEditView(projectCategory: ProjectCategory, indexPath: IndexPath) {
    guard let projectList = realmService.filter(projectCategory: projectCategory) else { return }
    guard let projectAddViewController = storyboard?.instantiateViewController(
      identifier: "\(ProjectAddViewController.self)",
      creator: { coder in ProjectAddViewController(
        realmService: self.realmService,
        uuid: projectList[indexPath.row].uuid,
        coder: coder
      )}
    ) else { return }

    navigationController?.present(projectAddViewController, animated: true)
  }
}

// MARK: - UILongPressGestureRecognizer

extension ProjectManagerHomeViewController {
  private func handleLongPress(
    _ collectionView: UICollectionView,
    projectCategory: ProjectCategory,
    gestureRecognizer: UILongPressGestureRecognizer
  ) {
    guard gestureRecognizer.state == .began else { return }

    let touchedLocation = gestureRecognizer.location(in: collectionView)

    guard let indexPath = collectionView.indexPathForItem(at: touchedLocation) else { return }
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }

    self.presentMoveMenuAlert(
      view: cell.contentView,
      projectCategory: projectCategory,
      indexPath: indexPath
    )
  }

  private func presentMoveMenuAlert(
    view: UIView,
    projectCategory: ProjectCategory,
    indexPath: IndexPath
  ) {
    let moveMenuAlertController = UIAlertController(
      title: nil,
      message: nil,
      preferredStyle: .actionSheet
    )

    moveMenuAlertController.modalPresentationStyle = .popover
    moveMenuAlertController.popoverPresentationController?.permittedArrowDirections = .up
    moveMenuAlertController.popoverPresentationController?.sourceView = view
    moveMenuAlertController.popoverPresentationController?.sourceRect = CGRect(
      origin: view.center,
      size: .zero
    )

    let firstMenuAction = UIAlertAction(
      title: "Move to \(projectCategory.moveCategoryMenu.first)",
      style: .default
    ) { _ in
      self.moveProjectCategory(
        current: projectCategory,
        to: projectCategory.moveCategoryMenu.first,
        indexPath: indexPath)
    }

    let secondMenuAction = UIAlertAction(
      title: "Move to \(projectCategory.moveCategoryMenu.second)",
      style: .default
    ) { _ in
      self.moveProjectCategory(
        current: projectCategory,
        to: projectCategory.moveCategoryMenu.second,
        indexPath: indexPath)
    }

    moveMenuAlertController.addAction(firstMenuAction)
    moveMenuAlertController.addAction(secondMenuAction)
    self.present(moveMenuAlertController, animated: true)
  }

  private func moveProjectCategory(
    current: ProjectCategory,
    to moveCategory: String,
    indexPath: IndexPath
  ) {
    guard let filteringProjects = realmService.filter(projectCategory: current) else { return }

    realmService.updateProjectCategory(
      uuid: filteringProjects[indexPath.row].uuid,
      moveCategory: moveCategory
    )
  }
}
