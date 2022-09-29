//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

import UIKit

private enum Design {
    static let alertControllerDefaultTitle = ""
    static let deleteSwipeActionTitle = "DELETE"
}

final class ProjectListViewModel {
    // MARK: - Properties
    
    private var useCase: ProjectUseCase
    private var todoList: Observable<[ProjectViewModel]>
    private var doingList: Observable<[ProjectViewModel]>
    private var doneList: Observable<[ProjectViewModel]>
    private var history: [String]
    
    // MARK: - Initializer
    
    init(todoList: Observable<[ProjectViewModel]>,
         doingList: Observable<[ProjectViewModel]>,
         doneList: Observable<[ProjectViewModel]>) {
        useCase = UseCase(repository: FirebaseRepository())
        history = [String]()
        self.todoList = todoList
        self.doingList = doingList
        self.doneList = doneList
    }
    
    // MARK: - Output to View
    
    func bindTodoList(closure: @escaping ([ProjectViewModel]) -> Void) {
        todoList.bind(closure)
    }
    
    func bindDoingList(closure: @escaping ([ProjectViewModel]) -> Void) {
        doingList.bind(closure)
    }
    
    func bindDoneList(closure: @escaping ([ProjectViewModel]) -> Void) {
        doneList.bind(closure)
    }
    
    func retrieveHistory() -> [String] {
        return history
    }
    
    func makeAlertContoller(tableView: UITableView,
                            indexPath: IndexPath,
                            state: ProjectState) -> UIAlertController {
        
        let alertController = UIAlertController(title: Design.alertControllerDefaultTitle,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        makeAlertAction(state: state,
                        indexPath: indexPath).forEach {
            alertController.addAction($0)
        }
        
        alertController.popoverPresentationController?.sourceView = tableView
        alertController.popoverPresentationController?.sourceRect = tableView.rectForRow(at: indexPath)
        alertController.popoverPresentationController?.permittedArrowDirections = [.up]
        
        return alertController
    }
    
    private func makeAlertAction(state: ProjectState,
                                 indexPath: IndexPath) -> [UIAlertAction] {
        let item = retrieveItems(state: state)[indexPath.row]
        let actionHandlers = makeActionHandlers(item: item)
        
        guard let firstActionHandler = actionHandlers.first,
              let lastActionHandler = actionHandlers.last
        else { return [UIAlertAction]() }
        
        let firstAction = UIAlertAction(title: item.workState.actionTitles.first,
                                        style: .default,
                                        handler: firstActionHandler)
        let lastAction = UIAlertAction(title: item.workState.actionTitles.second,
                                       style: .default,
                                       handler: lastActionHandler)
        
        return [firstAction, lastAction]
    }
    
    private func makeActionHandlers(item: ProjectViewModel) -> [((UIAlertAction) -> Void)?] {
        let actionHandlers = ProjectState.allCases.filter {
            $0 != item.workState
        }.map {
            makeHandler(item: item,
                        state: $0)
        }
        
        return actionHandlers
    }
    
    private func makeHandler(item: ProjectViewModel,
                             state: ProjectState) -> ((UIAlertAction) -> Void)? {
        let handler: ((UIAlertAction) -> Void) = { [self] ( _: UIAlertAction) in
            changeState(data: item, state: state)
        }
        
        return handler
    }
    
    func numberOfRow(with state: ProjectState) -> Int {
        return retrieveItems(state: state).count
    }
    
    func configureCellItem(cell: ProjectTableViewCell,
                           state: ProjectState,
                           indexPath: IndexPath) {
        
        let item = retrieveItems(state: state)[indexPath.row]
        cell.setItems(title: item.title,
                      body: item.body,
                      date: item.date.convertDateLocalization(),
                      dateColor: retrieveDateLabelColor(data: item.date))
    }
    
    private func retrieveDateLabelColor(data stringDate: String) -> UIColor {
        let date = stringDate.toDate()
        let currentDate = Date()
        
        if stringDate.convertDateLocalization() != currentDate.convertLocalization() && date < currentDate {
            return .systemRed
        }
        
        return .black
    }
    
    func retrieveItems(state: ProjectState) -> [ProjectViewModel] {
        switch state {
        case .todo:
            return todoList.value
        case .doing:
            return doingList.value
        case .done:
            return doneList.value
        }
    }
    
    func makeTableHeaderView(state: ProjectState) -> ProjectTableHeaderView {
        let items = retrieveItems(state: state)
        let view = ProjectTableHeaderView()
        
        ProjectState.allCases.filter {
            $0 == state
        }.forEach {
            view.setItems(title: $0.name,
                          count: items.count.description)
        }
        
        return view
    }
    
    func makeSwipeActions(state: ProjectState,
                          indexPath: IndexPath) -> [UIContextualAction] {
        let item = retrieveItems(state: state)[indexPath.row]
        let deleteSwipeAction = UIContextualAction(style: .destructive,
                                                   title: Design.deleteSwipeActionTitle,
                                                   handler: { [weak self] _, _, completionHaldler in
            self?.delete(id: item.id,
                         data: item)
            completionHaldler(true)
        })
        
        return [deleteSwipeAction]
    }
    
    // MARK: - Input from View
    
    func create(data: ProjectViewModel) {
        useCase.create(data: data)
        reloadLists()
        history.append(
            "Added '\(data.title)'.\n\(Date().convertLocalization())"
        )
    }
    
    private func read(completionHandler: @escaping ([ProjectViewModel]) -> Void) {
        useCase.read { viewModels in
            completionHandler(viewModels)
        }
    }
    
    func update(id: String,
                data: ProjectViewModel) {
        useCase.update(id: id,
                       data: data)
        reloadLists()
    }
    
    private func delete(id: String,
                        data: ProjectViewModel) {
        useCase.delete(id: id)
        reloadLists()
        history.append(
            "Removed '\(data.title)' from \(data.workState.name).\n\(Date().convertLocalization())"
        )
    }
    
    private func changeState(data: ProjectViewModel,
                             state: ProjectState) {
        let newData = ProjectViewModel(id: data.id,
                                       title: data.title,
                                       body: data.body,
                                       date: data.date,
                                       workState: state)
        
        update(id: data.id,
               data: newData)
        history.append(
            "Moved '\(data.title)' from \(data.workState.name) to \(state.name).\n\(Date().convertLocalization())"
        )
    }
    
    // MARK: - Methods
    
    func reloadLists() {
        read { [weak self] viewModels in
            let list = viewModels.sorted {
                $0.date.toDate() < $1.date.toDate()
            }
            
            self?.todoList.value = list.filter {
                $0.workState == .todo
            }
            
            self?.doingList.value = list.filter {
                $0.workState == .doing
            }
            
            self?.doneList.value = list.filter {
                $0.workState == .done
            }
        }
    }
}
