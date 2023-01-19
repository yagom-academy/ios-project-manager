//
//  todoItemViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/16.
//

import UIKit

protocol AddTodoViewDelegate: AnyObject {
    func addNewTodoItem(with item: TodoModel)
}

final class AddTodoViewController: UIViewController {
    weak var delegate: AddTodoViewDelegate?
    
    private let todoView: TodoItemView = TodoItemView()
    
    override func loadView() {
        view = todoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = TodoViewTitle.navigationBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: TodoViewTitle.cancel,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tappedCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: TodoViewTitle.done,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tappedDone))
    }
    
    @objc private func tappedCancel() {
        dismiss(animated: true)
    }
    
    @objc private func tappedDone() {
        let newTodoItem = TodoModel(title: todoView.titleTextField.text ?? "",
                                    body: todoView.bodyTextView.text,
                                    date: todoView.datePicker.date.convertDateToDouble())
        
        delegate?.addNewTodoItem(with: newTodoItem)
        dismiss(animated: true)
    }
}
