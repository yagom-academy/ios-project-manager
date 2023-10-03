//
//  ToDoDetailViewModel.swift
//  ProjectManager
//
//  Created by Moon on 2023/10/02.
//

import UIKit
import Combine

final class ToDoDetailViewModel {
    private let todo: ToDo
    private let dataManager: DataManager

    // 뷰에 데이터 보내는 용(뷰의 상태)
    let todoSubject: CurrentValueSubject<ToDo, Never>
    
    @Published var isEnableEdit: Bool
    @Published var background: UIColor?
    
    // 뷰에서 데이터 받는 용(뷰의 인풋)
    var title: String?
    var deadline: Date = .init()
    var body: String?
    
    // ToDo를 새로 만드는 경우
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.todo = dataManager.createToDo(category: .todo)
        self.todoSubject = .init(todo)
        self.isEnableEdit = true
        self.background = .systemBackground
        
        setUpNotifications()
    }
    
    // 셀을 선택해서 ToDo를 받는 경우
    init(todo: ToDo, dataManager: DataManager) {
        self.todo = todo
        self.dataManager = dataManager
        self.todoSubject = .init(todo)
        self.isEnableEdit = false
        self.background = .systemGray6
        
        setUpNotifications()
    }
    
    private func setUpNotifications() {
        // 유저와 상호작용이 가능하도록 하고 배경색 변경
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(enableEditContent),
                         name: NSNotification.Name("editButtonAction"),
                         object: nil
            )
        // viewWillDisappear 시점을 받아 dataManager에서 저장 수행
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(saveTodo),
                name: NSNotification.Name("ToDoDetailViewWillDisappear"),
                object: nil
            )
    }
    
    // 유저와 상호작용이 가능하도록 하고 배경색 변경
    @objc
    private func enableEditContent() {
        self.isEnableEdit = true
        self.background = .systemBackground
    }
    
    // viewWillDisappear 시점을 받아 dataManager에서 저장 수행
    @objc
    private func saveTodo() {
        todo.title = self.title
        todo.deadline = self.deadline
        todo.body = self.body
        
        dataManager.saveContext()
    }
}
