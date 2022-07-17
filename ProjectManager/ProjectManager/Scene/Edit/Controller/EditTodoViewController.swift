//
//  EditViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/10.
//

import UIKit

final class EditTodoViewController: UIViewController {
  private let viewModel: EditViewModel
  weak var delegate: TodoDelegate?
  private lazy var editView = WriteTodoView(frame: view.frame)
  
  init(viewModel: EditViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func loadView() {
    super.loadView()
    view = editView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigation()
    editView.setUserInteractionEnableViews(false)
    editView.updateTodoData(viewModel.item)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpNavigation() {
    navigationItem.title = HeaderName.todo
    navigationController?.navigationBar.barTintColor = UIColor.systemGray
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      systemItem: .edit, primaryAction: UIAction(
        handler: { [weak self] _ in
        self?.editView.setUserInteractionEnableViews(true)
      })
    )

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .done,
      primaryAction: UIAction(handler: { [weak self] _ in
        guard let self = self else { return }
        
        self.viewModel.doneButtonDidTap(
          title: self.editView.titleTextField.text,
          content: self.editView.contentTextView.text, date: self.editView.datePicker.date)
        self.dismiss(animated: true)
      })
    )
  }
  
//  private func saveUpdatedTodo() {
////    let state = viewModel.todo.state
////    var editedTodoData = makeFormTodoDate(state: state)
////    let id = viewModel.todo.id
//
//    editedTodoData.id = id
//
//    let todoModel = DBManager.shared.mappingTodoModel(from: editedTodoData)
////    let todoDictionary = mappingDictionary(from: editedTodoData)
//    // 에러발생
//    // DBManager.shared.update(todoModel, with: todoDictionary)
//    self.delegate?.updateData(editedTodoData)
//  }
  
//  private func mappingDictionary(from Todo: Todo) -> [String: Any?] {
//    var dictionary = [String: Any?]()
//
//    dictionary["title"] = viewModel.todo.title
//    dictionary["content"] = viewModel.todo.content
//    dictionary["date"] = viewModel.todo.date
//    dictionary["state"] = viewModel.todo.state
//    dictionary["identifier"] = viewModel.todo.id
//
//    return dictionary
//  }
}
