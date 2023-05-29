//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//

import Foundation
import Combine

final class DetailViewModel {
    @Published var title: String = ""
    @Published var body: String = ""
    var date: Date = Date()
    var workState: WorkState = .todo
    var id: UUID?
    weak var delegate: DetailViewModelDelegate?
    
    lazy var isEditingDone: AnyPublisher<Bool, Never> = Publishers.CombineLatest($title, $body)
        .map { title, body in
            return !title.isEmpty || !body.isEmpty
        }
        .eraseToAnyPublisher()
    
    init(from task: Task? = nil) {
        configureContents(with: task)
    }
    
    func createTask() {
        let task = Task(title: title, date: date, body: body, workState: workState)
        delegate?.createTask(task)
    }
    
    func updateTask() {
        guard let id else { return }
        let task = Task(title: title, date: date, body: body, workState: workState, id: id)
        delegate?.updateTask(task)
    }
    
    private func configureContents(with task: Task?) {
        if let task {
            self.title = task.title
            self.date = task.date
            self.body = task.body
            self.workState = task.workState
            self.id = task.id
        }
    }
}
