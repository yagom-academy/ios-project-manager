//
//  TodoCellViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/13.
//

import Foundation
import Combine

protocol TodoCellViewModelInput {
    func cellDidBind()
}

protocol TodoCellViewModelOutput {
    var state: PassthroughSubject<TodoCellViewModel.State, Never> { get }
}

protocol TodoCellViewModelable: TodoCellViewModelInput, TodoCellViewModelOutput {}

final class TodoCellViewModel: TodoCellViewModelable {
    
    // MARK: - Output
    
    enum State {
        case todoTitleEvent(title: String)
        case todoContentEvent(content: String)
        case todoDeadlineEvent(deadline: String)
        case expiredEvent
        case notExpiredEvent
    }
    
    let state = PassthroughSubject<State, Never>()
    
    private let todo: Todo
    private let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "yyyy. M. d."
        return formatter
    }()
    
    init(_ item: Todo) {
        self.todo = item
    }
    
    private func setDateLabelColor() {
        if Date() > endOfTheDay(for: todo.deadline) ?? Date() {
            state.send(.expiredEvent)
        } else {
            state.send(.notExpiredEvent)
        }
    }
    
    private func endOfTheDay(for date: Date) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        
        components.hour = 23
        components.minute = 59
        
        return calendar.date(from: components)
    }
}

extension TodoCellViewModel {
    
    // MARK: - Input
    
    func cellDidBind() {
        self.state.send(.todoTitleEvent(title: todo.title))
        self.state.send(.todoContentEvent(content: todo.content))
        self.state.send(.todoDeadlineEvent(deadline: dateformatter.string(from: todo.deadline)))
        
        setDateLabelColor()
    }
}
