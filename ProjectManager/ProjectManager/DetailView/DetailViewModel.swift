//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//

import Foundation
import Combine

final class DetailViewModel {
    enum Mode {
        case create
        case update
        
        var leftButtonTitle: String {
            switch self {
            case .create:
                return "Cancel"
            case .update:
                return "Edit"
            }
        }
    }
    
    @Published var title: String = ""
    @Published var body: String = ""
    
    var date: Date = Date()
    var workState: WorkState = .todo
    var id: UUID?
    
    let mode: Mode
    
    weak var delegate: DetailViewModelDelegate?
    
    lazy var isEditingDone: AnyPublisher<Bool, Never> = Publishers.CombineLatest($title, $body)
        .map { title, body in
            return !title.isEmpty || !body.isEmpty
        }
        .eraseToAnyPublisher()
    
    init(from task: Task? = nil, mode: DetailViewModel.Mode) {
        self.mode = mode
        configureContents(with: task)
    }
    
    func createTask() {
        let task = Task(title: title, date: date, body: body, workState: workState)
        delegate?.setState(isUpdating: false)
        delegate?.createTask(task)
    }
    
    func updateTask() {
        guard let id else { return }
        let task = Task(title: title, date: date, body: body, workState: workState, id: id)
        delegate?.setState(isUpdating: true)
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
