//
//  EditViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/10.
//

import UIKit

final class EditTodoViewController: UIViewController {
  let viewModel: EditViewModel
  weak var delegate: TodoDelegate?
  lazy var editView = WriteTodoView(frame: view.frame)
  
  init(todo: Todo) {
    self.viewModel = EditViewModel(todo: todo)
    super.init(nibName: nil, bundle: nil)
  }
  
  override func loadView() {
    super.loadView()
    view = editView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigation()
    editView.updateTodoData(viewModel.todo)
    editView.setUserInteractionEnableViews(false)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func makeFormTodoDate(state: State) -> Todo {
    var editedTodoDate = editView.createTodoData(state: state)
    editedTodoDate.id = viewModel.todo.id
    
    return editedTodoDate
  }
  
  private func setUpNavigation() {
    navigationItem.title = "TODO"
    navigationController?.navigationBar.barTintColor = UIColor.systemGray
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      systemItem: .edit, primaryAction: UIAction(handler: { [weak self] _ in
        self?.editView.setUserInteractionEnableViews(true)
      }))

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .done,
      primaryAction: UIAction(handler: { [weak self] _ in
        guard let state = self?.viewModel.todo.state,
              var editedTodoData = self?.makeFormTodoDate(state: state) else { return }
        editedTodoData.id = self!.viewModel.todo.id
        
        let todoModel = DBManager.shared.mappingTodoModel(from: editedTodoData)
        guard let todoDictionary = self?.mappingDictionary(from: editedTodoData) else { return }
        
        self?.delegate?.updateData(editedTodoData)
        self?.dismiss(animated: true)
      }))
  }
  
  func mappingDictionary(from Todo: Todo) -> [String: Any?] {
    var dictionary = [String: Any?]()
    
    dictionary["title"] = viewModel.todo.title
    dictionary["content"] = viewModel.todo.content
    dictionary["date"] = viewModel.todo.date
    dictionary["state"] = viewModel.todo.state
    dictionary["identifier"] = viewModel.todo.id
    
    return dictionary
  }
}
