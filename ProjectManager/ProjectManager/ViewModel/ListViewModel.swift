//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import Foundation

final class ListViewModel {
    // Model이 변경되면 ListViewController의 테이블뷰를 업데이트
    var todoList: [Todo]? {
        didSet {
            bindTodoList?()
        }
    }
    
    // ListHeader의 contentAmountLabel와 바인딩할 변수
    var count: String {
        didSet {
            bindCount?(self)
        }
    }
    
    // ListHeader의 contentAmountLabel와 바인딩하기 위한 클로저
    private var bindCount: ((ListViewModel) -> Void)?
    
    // ListViewController의 테이블뷰를 업데이트하기 위한 클로저
    private var bindTodoList: (() -> Void)?
    
    init() {
        count = String(todoList?.count ?? 0)
        
        setUpNotifications()
    }
    
    // ListViewController의 viewDidLoad 시점을 받아 모델을 로드할 수 있도록 함
    private func setUpNotifications() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(loadTodoList),
                name: NSNotification.Name("ListViewControllerViewDidLoad"),
                object: nil
            )
    }
    
    @objc
    private func loadTodoList() {
        todoList = [
            Todo(title: "1", description: "111", deadline: Date()),
            Todo(title: "2", description: "222", deadline: Date()),
            Todo(title: "3", description: "333", deadline: Date()),
            Todo(title: "4", description: "444", deadline: Date()),
            Todo(title: "5", description: "555", deadline: Date()),
            Todo(title: "6", description: "666", deadline: Date())
        ]
    }
    
    func bindCount(_ handler: @escaping (ListViewModel) -> Void) {
        handler(self)
        bindCount = handler
    }
    
    func bindTodoList(_ handler: @escaping () -> Void) {
        handler()
        bindTodoList = handler
    }
}
