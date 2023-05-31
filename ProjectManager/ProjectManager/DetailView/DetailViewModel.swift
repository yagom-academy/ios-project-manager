//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//

import Foundation
import Combine

enum EditError: Error {
    case nilText
}

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
    @Published var body: String? = ""
    
    lazy var isEditingDone: AnyPublisher<Bool, Error> = Publishers.CombineLatest($title, $body)
        .tryMap { title, body in
            guard let body else { throw EditError.nilText }
            return !title.isEmpty || !body.isEmpty
        }
        .eraseToAnyPublisher()
    
    let mode: Mode
    var date: Date = Date()
    weak var delegate: DetailViewModelDelegate?
    
    private var workState: WorkState = .todo
    private var id: UUID?
    
    init(from task: Task? = nil, mode: DetailViewModel.Mode) {
        self.mode = mode
        configureContents(with: task)
    }
    
    func createTask() {
        guard let body else { return }
        let task = Task(title: title, date: date, body: body, workState: workState)
        delegate?.setState(isUpdating: false)
        delegate?.createTask(task)
    }
    
    func updateTask() {
        guard let id, let body else { return }
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
