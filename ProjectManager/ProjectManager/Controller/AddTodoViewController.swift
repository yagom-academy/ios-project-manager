//
//  AddTodoViewController.swift
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
        todoView.bodyTextView.delegate = self
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

extension AddTodoViewController: LimitableTextView {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text,
              let range = Range(range, in: currentText) else {
            return false
        }
       
        let changedText = currentText.replacingCharacters(in: range, with: text)
        return changedText.count <= TodoItemValue.bodyLimit
    }
}
