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
    
    lazy var isEditingDone: AnyPublisher<Bool, Never> = Publishers.CombineLatest($title, $body)
        .map { title, body in
            return !title.isEmpty || !body.isEmpty
        }
        .eraseToAnyPublisher()
    
    let detailService = DetailService()
    
    init(task: Task? = nil) {
        configureContents(with: task)
    }
    
    func createTask() {
        detailService.createTask(title: title, date: date, body: body)
    }
    
    func updateTask() {
        guard let id else { return }
        detailService.updateTask(id: id, title: title, date: date, body: body, workState: workState)
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
