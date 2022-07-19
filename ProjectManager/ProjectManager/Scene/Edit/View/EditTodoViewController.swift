//
//  EditViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/10.

import UIKit

final class EditTodoViewController: UIViewController {
  private let viewModel: EditViewModel
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
    setUpNotification()
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
          self?.changeNavigationLeftBar()
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
  
  private func changeNavigationLeftBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      systemItem: .cancel,
      primaryAction: UIAction(handler: { [weak self] _ in
        self?.dismiss(animated: true)
      })
    )
  }
  
  deinit {
    RealmError.removeObserver(vc: self)
  }
}

private extension EditTodoViewController {
  func setUpNotification() {
    RealmError.addObserver(selector: #selector(showErrorAlert), vc: self)
  }
  
  @objc func showErrorAlert(_ notification: Notification) {
    guard let error = notification.object as? Error else {
      return
    }
    
    let alertViewController = UIAlertController(
      title: "RealmError",
      message: "\(error) \nTodo를 등록하세요. \n(우측상단에 + 버튼을 클릭)",
      preferredStyle: .alert
    )
    
    let checkAction = UIAlertAction(title: "확인", style: .default)
    
    alertViewController.addAction(checkAction)
    
    present(alertViewController, animated: true)
  }
}
