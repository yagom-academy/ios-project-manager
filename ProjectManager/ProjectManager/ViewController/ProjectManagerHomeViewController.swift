//
//  ProjectManager - ProjectManagerHomeViewController.swift
//  Created by Minseong. 
// 

import UIKit

import RealmSwift

final class ProjectManagerHomeViewController: UIViewController {
  @IBOutlet private weak var todoTableView: UITableView!
  @IBOutlet private weak var doingTableView: UITableView!
  @IBOutlet private weak var doneTableView: UITableView!
  @IBOutlet private weak var todoCountLabel: UILabel!
  @IBOutlet private weak var doingCountLabel: UILabel!
  @IBOutlet private weak var doneCountLabel: UILabel!

  private let realmService = RealmService()
  private var projects: Results<Project>?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.projects = realmService.readAll(projectType: Project.self)
    self.initializeNavigationBar()
    self.initializeTableView()
    self.setCountLabelCornerRadius()
    self.realmService.reloadDataWhenChangedRealmData(
      [todoTableView, doingTableView, doneTableView]
    )
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.realmService.invalidateNotificationToken()
  }

  private func initializeNavigationBar() {
    self.navigationItem.title = "Project Manager"
  }

  private func initializeTableView() {
    [todoTableView, doingTableView, doneTableView].forEach {
      $0?.dataSource = self
      $0?.delegate = self
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

  @IBAction private func longPressTodoTableView(_ sender: UILongPressGestureRecognizer) {
    self.handleLongPress(todoTableView, projectCategory: .todo, gestureRecognizer: sender)
  }

  @IBAction private func longPressDoingTableView(_ sender: UILongPressGestureRecognizer) {
    self.handleLongPress(doingTableView, projectCategory: .doing, gestureRecognizer: sender)
  }

  @IBAction private func longPressDoneTableView(_ sender: UILongPressGestureRecognizer) {
    self.handleLongPress(doneTableView, projectCategory: .done, gestureRecognizer: sender)
  }
}

// MARK: - UITableViewDataSource

extension ProjectManagerHomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let proejctCategory = self.fetchProejctCategory(from: tableView) else { return .zero }
    let itemCount = fetchItemCount(from: proejctCategory)

    self.configureCountLabel(projectCategory: proejctCategory, itemCount: itemCount)

    return itemCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "\(ProjectManagerTableViewCell.self)",
      for: indexPath
    ) as? ProjectManagerTableViewCell else {
      return UITableViewCell()
    }
    guard let projectList = fetchProjectList(in: tableView) else { return cell}

    cell.configure(
      title: projectList[indexPath.row].title,
      body: projectList[indexPath.row].body ?? "",
      date: projectList[indexPath.row].date
    )

    return cell
  }

  private func fetchProejctCategory(from tableView: UITableView) -> ProjectCategory? {
    let projectCategory: [UITableView: ProjectCategory] = [
      self.todoTableView: .todo,
      self.doingTableView: .doing,
      self.doneTableView: .done
    ]

    return projectCategory[tableView]
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

  private func fetchProjectList(in tableView: UITableView) ->  Results<Project>? {
    guard let projectCategory = fetchProejctCategory(from: tableView) else { return nil }
    guard let projectList = realmService.filter(projectCategory: projectCategory) else { return nil }

    return projectList
  }
}

// MARK: - UITableViewDelegate

extension ProjectManagerHomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    guard let projectCategory = fetchProejctCategory(from: tableView) else { return }

    self.presentProjectEditView(projectCategory: projectCategory, indexPath: indexPath)
  }

  func tableView(
    _ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    guard let projectList = fetchProjectList(in: tableView) else { return nil }

    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
      _, _, actionPerformed in
      self.realmService.delete(project: projectList[indexPath.row])
      actionPerformed(true)
    }

    return UISwipeActionsConfiguration(actions: [deleteAction])
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
    _ tableView: UITableView,
    projectCategory: ProjectCategory,
    gestureRecognizer: UILongPressGestureRecognizer
  ) {
    guard gestureRecognizer.state == .began else { return }

    let touchedLocation = gestureRecognizer.location(in: tableView)

    guard let indexPath = tableView.indexPathForRow(at: touchedLocation) else { return }
    guard let cell = tableView.cellForRow(at: indexPath) else { return }

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
