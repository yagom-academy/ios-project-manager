//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import Foundation

final class ListCellViewModel {
    // 바인딩을 위한 클로저 타입
    typealias bind = ((ListCellViewModel) -> Void)
    
    // 바인딩할 데이터를 가지고 있는 모델
    private let todo: Todo
    
    // 바인딩에 사용할 변수들
    var title: String {
        didSet {
            bindTitle?(self)
        }
    }
    
    var description: String {
        didSet {
            bindDescription?(self)
        }
    }
    
    var deadline: String {
        didSet {
            bindDeadline?(self)
        }
    }
    
    // ListCell에서 각각의 레이블을 바인딩하기 위한 클로저들
    private var bindTitle: bind?
    private var bindDescription: bind?
    private var bindDeadline: bind?
    
    // deadline 바인딩을 위한 포맷팅용
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. M. d."
        
        return formatter
    }()
    
    init(todo: Todo) {
        self.todo = todo
        title = todo.title
        description = todo.description
        deadline = dateFormatter.string(from: todo.deadline)
    }
    
    func bindTitle(_ handler: @escaping bind) {
        handler(self)
        bindTitle = handler
    }
    
    func bindDescription(_ handler: @escaping bind) {
        handler(self)
        bindDescription = handler
    }
    
    func bindDeadline(_ handler: @escaping bind) {
        handler(self)
        bindDeadline = handler
    }
}
