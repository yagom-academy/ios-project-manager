//
//  WriteViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/10

import UIKit

class WriteViewController: UIViewController {
  weak var todoDelegate: TodoDelegate?
  lazy var writeView = WriteView(frame: view.frame)
  
  override func loadView() {
    super.loadView()
    view = writeView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTitle()
  }
  
  func setTitle() {
    navigationItem.title = "TODO"
    navigationController?.navigationBar.barTintColor = UIColor.systemGray
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      systemItem: .cancel, primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true)
      }))

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .done,
      primaryAction: UIAction(handler: { [weak self] _ in
        guard let writedTodoData = self?.writeView.createTodoData(state: .todo) else { return }
        self?.todoDelegate?.createData(writedTodoData)
        self?.dismiss(animated: true)
      }))
  }
}
