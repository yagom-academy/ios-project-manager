//
//  EditTodoViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/17.
//

import UIKit

protocol EditTodoViewDelegate: AnyObject {
    func editTodoItem(with item: TodoModel)
}

class EditTodoViewController: UIViewController {
    weak var delegate: EditTodoViewDelegate?
    
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
        guard var itemBeEdited = self.todoItem else { return }
        
        itemBeEdited.title = todoView.titleTextField.text ?? ""
        itemBeEdited.body = todoView.bodyTextView.text ?? ""
        itemBeEdited.date = todoView.datePicker.date.timeIntervalSince1970
        
        delegate?.editTodoItem(with: itemBeEdited)
    }
    
    @objc private func tappedDone() {
        dismiss(animated: true)
    }
    
    func prepareEditView(with itemBeEdited: TodoModel) {
        self.todoItem = itemBeEdited
        
        todoView.updateContent(title: itemBeEdited.title, body: itemBeEdited.body, date: itemBeEdited.date)
    }
}
