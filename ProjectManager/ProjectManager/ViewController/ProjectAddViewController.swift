//
//  ProjectAddViewController.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/13.
//

import UIKit

import RealmSwift

final class ProjectAddViewController: UIViewController {
  @IBOutlet private weak var projectTitleTextField: UITextField!
  @IBOutlet private weak var projectDatePicker: UIDatePicker!
  @IBOutlet private weak var projectBodyTextView: UITextView!

  private let realmService: RealmService?
  private let uuid: String?

  init?(realmService: RealmService?, uuid: String? = nil, coder: NSCoder) {
    self.realmService = realmService
    self.uuid = uuid
    super.init(coder: coder)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.initializeUI()
    self.configureEditView(uuid: uuid)
  }

  private func initializeUI() {
    self.projectTitleTextField.leftView = UIView(
      frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0)
    )
    self.projectTitleTextField.leftViewMode = .always
    self.projectTitleTextField.shadow(
      borderWidth: 1,
      borderColor: UIColor.systemGray5.cgColor,
      shadowColor: UIColor.black.cgColor,
      shadowOffset: CGSize(width: -1, height: 4),
      shadowOpacity: 0.3
    )
    self.projectBodyTextView.shadow(
      borderWidth: 1,
      borderColor: UIColor.systemGray5.cgColor,
      shadowColor: UIColor.black.cgColor,
      shadowOffset: CGSize(width: -1, height: 4),
      shadowOpacity: 0.3
    )
  }

  private func configureEditView(uuid: String?) {
    guard let uuid = uuid else { return }
    guard let project = realmService?.readTarget(uuid: uuid, projectType: Project.self) else { return }
    self.projectLeftBarButtonItem.title = "Edit"
    self.projectTitleTextField.text = project.title
    self.projectDatePicker.date = project.date
    self.projectBodyTextView.text = project.body
  }

  @IBAction func cancelButton(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true)
  }

  @IBAction func doneButton(_ sender: UIBarButtonItem) {
    if projectTitleTextField.text?.isEmpty == true { return }

    let project = Project(
      uuid: UUID().uuidString,
      title: projectTitleTextField.text ?? "",
      body: projectBodyTextView.text,
      date: projectDatePicker.date,
      projectCategory: ProjectCategory.todo.description
    )

    self.realmService?.create(project: project)
    self.dismiss(animated: true)
  }
}
