//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/16.
//

import UIKit

protocol AddableNewTodoItem {
    func addNewTodoItem(with item: TodoModel)
}

final class TodoViewController: UIViewController {
    var delegate: AddableNewTodoItem?
    
    private let todoView: TodoView = TodoView()
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tappedCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
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
                                    date: todoView.datePicker.date.timeIntervalSince1970)
        
        delegate?.addNewTodoItem(with: newTodoItem)
        dismiss(animated: true)
    }
}
