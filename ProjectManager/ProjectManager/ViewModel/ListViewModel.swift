//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import Foundation

final class ListViewModel {
    let dataManager = DataManager()
    
    // Model이 변경되면 ListViewController의 테이블뷰를 업데이트
    // ListHeader에 표시되는 count도 업데이트
    var todoList: [ToDo]? {
        didSet {
            bindTodoList?()
            count = String(todoList?.count ?? 0)
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
    
    private func setUpNotifications() {
        // viewDidLoad 시점을 받아 모델을 로드할 수 있도록 함
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(loadTodoList),
                name: NSNotification.Name("ListViewControllerViewDidLoad"),
                object: nil
            )
        // dataManager에서 저장이 이루어졌을 때 모델을 다시 로드
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(loadTodoList),
                name: NSNotification.Name("CalledSaveContext"),
                object: nil
            )
    }
    
    @objc
    private func loadTodoList() {
        todoList = dataManager.fetchToDoList()
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
