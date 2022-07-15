//
//  WriteViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/10

import UIKit

final class WriteTodoViewController: UIViewController {
  weak var todoDelegate: TodoDelegate?
  private lazy var writeView = WriteTodoView(frame: view.frame)
  
  override func loadView() {
    super.loadView()
    view = writeView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigation()
  }
  
  private func setUpNavigation() {
    navigationItem.title = "TODO"
    navigationController?.navigationBar.barTintColor = UIColor.systemGray
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      systemItem: .cancel,
      primaryAction: UIAction(
        handler: { _ in
          self.dismiss(animated: true)
        })
    )
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .done,
      primaryAction: UIAction(
        handler: { [weak self] _ in
          self?.createTodo()
          self?.dismiss(animated: true)
        })
    )
  }
  
  private func createTodo() {
    let writedTodoData = writeView.createTodoData(state: .todo)
    
    let realmTodo = DBManager.shared.mappingTodoModel(from: writedTodoData)
    DBManager.shared.create(realmTodo)
    
    self.todoDelegate?.createData(writedTodoData)
  }
}
