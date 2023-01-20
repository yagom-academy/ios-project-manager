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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: TodoViewTitle.edit,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tappedEdit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: TodoViewTitle.done,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tappedDone))
    }
    
    @objc private func tappedEdit() {
        guard var itemBeEdited = todoItem else { return }
        
        itemBeEdited.title = todoView.titleTextField.text ?? ""
        itemBeEdited.body = todoView.bodyTextView.text ?? ""
        itemBeEdited.date = todoView.datePicker.date.convertDateToDouble()
        
        delegate?.editTodoItem(with: itemBeEdited)
    }
    
    @objc private func tappedDone() {
        dismiss(animated: true)
    }
    
    func prepareView(with itemBeEdited: TodoModel) {
        todoItem = itemBeEdited
        todoView.updateContent(title: itemBeEdited.title,
                               body: itemBeEdited.body,
                               date: itemBeEdited.date.convertDoubleToDate())
    }
}

extension EditTodoViewController: LimitableTextCount {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text,
              let range = Range(range, in: currentText) else {
            return false
        }
       
        let changedText = currentText.replacingCharacters(in: range, with: text)
        return changedText.count <= TodoItemValue.bodyLimit
    }
}
