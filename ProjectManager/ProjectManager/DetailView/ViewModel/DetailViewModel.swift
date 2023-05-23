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
    var id: UUID?
    
    lazy var isEditingDone: AnyPublisher<Bool, Never> = Publishers.CombineLatest($title, $body)
        .map { title, body in
            return !title.isEmpty || !body.isEmpty
        }
        .eraseToAnyPublisher()
    
    let detailService = DetailService()
    
    init(task: Task? = nil) {
        if let task {
            title = task.title
            date = task.date
            body = task.body
            id = task.id
        }
    }
    
    func createTask() {
        detailService.createTask(title: title, date: date, body: body)
    }
}
