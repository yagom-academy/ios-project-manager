//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import Foundation

final class ListViewModel {
    var todoList: [Todo]
    
    // ListHeader의 contentAmountLabel와 바인딩할 변수
    var count: String {
        didSet {
            bindCount?(self)
        }
    }
    // ListHeader의 contentAmountLabel와 바인딩하기 위한 클로저
    private var bindCount: ((ListViewModel) -> Void)?
    
    init() {
        todoList = [
            Todo(title: "1", description: "111", deadline: Date()),
            Todo(title: "2", description: "222", deadline: Date()),
            Todo(title: "3", description: "333", deadline: Date()),
            Todo(title: "4", description: "444", deadline: Date()),
            Todo(title: "5", description: "555", deadline: Date()),
            Todo(title: "6", description: "666", deadline: Date())
        ]
        
        count = String(todoList.count)
    }
    
    func bindCount(_ handler: @escaping (ListViewModel) -> Void) {
        handler(self)
        bindCount = handler
    }
}
