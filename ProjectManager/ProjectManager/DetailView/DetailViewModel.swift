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
    
    @Published var title: String? = ""
    @Published var body: String? = ""
    
    lazy var isEditingDone: AnyPublisher<Bool, Error> = Publishers.CombineLatest($title, $body)
        .tryMap { title, body in
            guard let title, let body else { throw EditError.nilText }
            return !title.isEmpty || !body.isEmpty
        }
        .eraseToAnyPublisher()
    
    let mode: Mode
    var date: Date = Date()
    weak var delegate: DetailViewModelDelegate?
    
    private var workState: WorkState = .todo
    private var id: UUID?
    
    init(from plan: Plan? = nil, mode: DetailViewModel.Mode) {
        self.mode = mode
        configureContents(with: plan)
    }
    
    func createplan() {
        guard let title, let body else { return }
        let plan = Plan(title: title, date: date, body: body, workState: workState)
        delegate?.setState(isUpdating: false)
        delegate?.createplan(plan)
    }
    
    func updateplan() {
        guard let title, let id, let body else { return }
        let plan = Plan(title: title, date: date, body: body, workState: workState, id: id)
        delegate?.setState(isUpdating: true)
        delegate?.updateplan(plan)
    }
    
    private func configureContents(with plan: Plan?) {
        if let plan {
            self.title = plan.title
            self.date = plan.date
            self.body = plan.body
            self.workState = plan.workState
            self.id = plan.id
        }
    }
}
