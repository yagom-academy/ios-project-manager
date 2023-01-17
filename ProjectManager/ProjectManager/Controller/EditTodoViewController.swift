//
//  EditTodoViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/17.
//

import UIKit

protocol EditTodoViewDelegate {
    func editTodoItem(with item: TodoModel)
}

class EditTodoViewController: UIViewController {
    var delegate: EditTodoViewDelegate?
    
    private let todoView: TodoItemView = TodoItemView()
    
    private var todoItem: TodoModel?
    
    override func loadView() {
        self.view = todoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tappedEdit))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tappedDone))
    }
    
    @objc private func tappedEdit() {
        guard var editedTodoItem = self.todoItem else { return }
        
        editedTodoItem.title = todoView.titleTextField.text ?? ""
        editedTodoItem.body = todoView.bodyTextView.text ?? ""
        editedTodoItem.date = todoView.datePicker.date.timeIntervalSince1970
        
        delegate?.editTodoItem(with: editedTodoItem)
    }
    
    @objc private func tappedDone() {
        dismiss(animated: true)
    }
    
    func prepareEditView(with todoItem: TodoModel) {
        self.todoItem = todoItem
        
        todoView.updateContent(title: todoItem.title,
                               body: todoItem.body,
                               date: todoItem.date)
    }
}
