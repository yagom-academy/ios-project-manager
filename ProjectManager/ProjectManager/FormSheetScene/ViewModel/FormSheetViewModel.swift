//
//  CreateTodoListViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class FormSheetViewModel {
    let mode: PageMode
    private var currentTodo: Todo?
    
    init(mode: PageMode, category: String?, index: Int?) {
        self.mode = mode
        guard let category = category,
              let index = index else {
            return
        }
        self.currentTodo = TodoDataManager.shared.read(category: category)?[index]
    }
    
    func viewDidLoad(_ viewController: FormSheetViewController) {
        switch mode {
        case .create:
            return
        case .edit:
            setupData(with: currentTodo,
                      in: viewController.formSheetView)
        }
    }
    
    func setupData(with model: Todo?, in view: FormSheetTemplateView) {
        guard let model = model else { return }
        view.titleTextField.text = model.title
        view.datePicker.date = model.date
        view.bodyTextView.text = model.body
    }
    
    func generateTodoModel(in view: FormSheetTemplateView) -> Todo? {
        guard let title = view.titleTextField.text,
              let body = view.bodyTextView.text else { return nil }
        let date = view.datePicker.date
        let todo = Todo()
        todo.category = currentTodo?.category ?? Category.todo
        todo.title = title
        todo.body = body
        todo.date = date
        return todo
    }
    
    func edit(to nextTodo: Todo) {
        guard let currentTodo = currentTodo else {
            return
        }
        TodoDataManager.shared.update(todo: currentTodo, with: nextTodo)
    }
    
    func create(_ todo: Todo) {
        TodoDataManager.shared.create(with: todo)
    }
}
