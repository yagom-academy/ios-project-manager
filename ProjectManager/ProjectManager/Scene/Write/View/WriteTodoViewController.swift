//
//  WriteViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/10

import UIKit

final class WriteTodoViewController: UIViewController {
  private lazy var writeView = WriteTodoView(frame: view.frame)
  private let viewModel: WriteViewModel
  
  init(viewModel: WriteViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = writeView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigation()
    setUpNotification()
  }
  
  private func setUpNavigation() {
    navigationItem.title = HeaderName.todo
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
          self?.viewModel.doneButtonDidTap(
            title: self?.writeView.titleTextField.text,
            content: self?.writeView.contentTextView.text,
            date: self?.writeView.datePicker.date
          )
          
          self?.dismiss(animated: true)
        })
    )
  }
  
  deinit {
    RealmError.removeObserver(vc: self)
  }
}

private extension WriteTodoViewController {
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
