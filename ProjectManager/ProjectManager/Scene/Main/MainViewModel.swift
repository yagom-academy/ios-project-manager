//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import RxSwift
import RxRelay
import RxCocoa

protocol MainViewModelInOut: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelOutput {
    var todoList: Driver<[ListItem]> { get }
    var doingList: Driver<[ListItem]> { get }
    var doneList: Driver<[ListItem]> { get }
    func isOverDeadline(listItem: ListItem) -> Bool
    func listCount(_ type: ListType) -> Driver<String>
    
    var showAddView: PublishRelay<Void> { get }
    var showEditView: PublishRelay<ListItem> { get }
    var showErrorAlert: PublishRelay<String?> { get }
}

protocol MainViewModelInput {
    func touchAddButton()
    func touchCell(index: Int, type: ListType)
    func deleteCell(index: Int, type: ListType)
    func changeItemType(index: Int, type: ListType, to: ListType)
}

final class MainViewModel: MainViewModelInOut {
    private var storage: AppStoregeable

//MARK: - output
    let todoList: Driver<[ListItem]>
    let doingList: Driver<[ListItem]>
    let doneList: Driver<[ListItem]>
    
    init(storage: AppStoregeable) {
        self.storage = storage
        
        todoList = storage.todoList.asDriver(onErrorJustReturn: [])
        doingList = storage.doingList.asDriver(onErrorJustReturn: [])
        doneList = storage.doneList.asDriver(onErrorJustReturn: [])
        
        if UserDefaults.standard.bool(forKey: "lunchedBefore") == false {
            setList()
        }
    }
    
    private func setList() {
        print("activity indicator 시작")
        storage.setList { result in
            switch result {
            case .success():
                UserDefaults.standard.set(true, forKey: "lunchedBefore")
            case .failure(let error):
                self.showErrorAlert.accept(error.errorDescription)
            }
            print("activity indicator 종료")
        }
    }
    
    func listCount(_ type: ListType) -> Driver<String> {
        switch type {
        case .todo:
            return todoList.map{ "\($0.count)"}
        case .doing:
            return doingList.map{ "\($0.count)"}
        case .done:
            return doneList.map{ "\($0.count)"}
        }
    }
    
    var showAddView = PublishRelay<Void>()
    var showEditView = PublishRelay<ListItem>()
    var showErrorAlert = PublishRelay<String?>()
}

//MARK: - input
extension MainViewModel {
    func isOverDeadline(listItem: ListItem) -> Bool {
        return listItem.type != .done && listItem.deadline < Date()
    }
    
    func touchAddButton() {
        showAddView.accept(())
    }
    
    func touchCell(index: Int, type: ListType) {
        let item = storage.selectItem(index: index, type: type)
        showEditView.accept(item)
    }
    
    func deleteCell(index: Int, type: ListType) {
        do {
            try storage.deleteItem(index: index, type: type)
        } catch {
            guard let error = error as? StorageError else {
                showErrorAlert.accept(nil)
                return
            }
            
            showErrorAlert.accept(error.errorDescription)
        }
    }
    
    func changeItemType(index: Int, type: ListType, to destination: ListType) {
        do {
            try storage.changeItemType(index: index, type: type, destination: destination)
        } catch {
            guard let error = error as? StorageError else {
                showErrorAlert.accept(nil)
                return
            }
            
            showErrorAlert.accept(error.errorDescription)
        }
    }
}
