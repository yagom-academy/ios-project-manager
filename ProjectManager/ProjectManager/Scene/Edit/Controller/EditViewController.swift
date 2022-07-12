//
//  EditViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/10.
//

import UIKit

final class EditViewController: UIViewController {
  let todo: Todo
  weak var delegate: TodoDelegate?
  lazy var editView = WriteView(frame: view.frame)
  
  init(todo: Todo = Todo()) {
    self.todo = todo
    super.init(nibName: nil, bundle: nil)
  }
  
  override func loadView() {
    super.loadView()
    view = editView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTitle()
    editView.updateTodoData(todo)
    editView.setUserInteractionEnableViews(false)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func makeFormTodoDate(state: State) -> Todo {
    var editedTodoDate = editView.createTodoData(state: state)
    editedTodoDate.identifier = todo.identifier
    
    return editedTodoDate
  }
  
  private func setTitle() {
    navigationItem.title = "TODO"
    navigationController?.navigationBar.barTintColor = UIColor.systemGray
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      systemItem: .edit, primaryAction: UIAction(handler: { [weak self] _ in
        self?.editView.setUserInteractionEnableViews(true)
      }))

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .done,
      primaryAction: UIAction(handler: { [weak self] _ in
        guard let state = self?.todo.state,
              var editedTodoData = self?.makeFormTodoDate(state: state) else { return }
        editedTodoData.identifier = self!.todo.identifier
        self?.delegate?.updateData(editedTodoData)
        self?.dismiss(animated: true)
      }))
  }
}
