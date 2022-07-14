//
//  ProjectAddViewController.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/13.
//

import UIKit

import RealmSwift

final class ProjectAddViewController: UIViewController {
  @IBOutlet weak var addProjectTitleTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var bodyTextView: UITextView!

  private let realmService: RealmService?

  init?(realmService: RealmService, coder: NSCoder) {
    self.realmService = realmService
    super.init(coder: coder)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.initializeUI()
  }

  private func initializeUI() {
    self.addProjectTitleTextField.leftView = UIView(
      frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0)
    )
    self.addProjectTitleTextField.leftViewMode = .always
    self.addProjectTitleTextField.shadow(
      borderWidth: 1,
      borderColor: UIColor.systemGray5.cgColor,
      shadowColor: UIColor.black.cgColor,
      shadowOffset: CGSize(width: -1, height: 4),
      shadowOpacity: 0.3
    )
    self.bodyTextView.shadow(
      borderWidth: 1,
      borderColor: UIColor.systemGray5.cgColor,
      shadowColor: UIColor.black.cgColor,
      shadowOffset: CGSize(width: -1, height: 4),
      shadowOpacity: 0.3
    )
  }
}
