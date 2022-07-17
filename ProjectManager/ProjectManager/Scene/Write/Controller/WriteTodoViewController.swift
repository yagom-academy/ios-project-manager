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
}
