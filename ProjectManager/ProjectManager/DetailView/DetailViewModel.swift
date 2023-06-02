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
    case nilViewModel
}

protocol DetailViewModelDelegate: PlanManagable { }

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
    
    struct Input {
        let titleTextEvent: AnyPublisher<String?, Never>
        let bodyTextEvent: AnyPublisher<String?, Never>
        let datePickerEvent: AnyPublisher<Date, Never>
    }
    
    struct Output {
        let isEditingDone: AnyPublisher<Bool, Error>
    }
    
    let mode: Mode
    
    var title: String? = ""
    var body: String? = ""
    var date: Date = Date()
    
    weak var delegate: DetailViewModelDelegate?
    
    private var workState: WorkState = .todo
    private var id: UUID?
    
    init(from plan: Plan? = nil, mode: DetailViewModel.Mode) {
        self.mode = mode
        configureContents(with: plan)
    }
    
    func createPlan() {
        guard let title, let body else { return }
        let plan = Plan(title: title, date: date, body: body, workState: workState)
        delegate?.create(plan: plan)
    }
    
    func updatePlan() {
        guard let title, let id, let body else { return }
        let plan = Plan(title: title, date: date, body: body, workState: workState, id: id)
        delegate?.update(plan: plan)
    }
    
    func transform(input: Input) -> Output {
        let titlePublisher = input.titleTextEvent
            .tryMap { [weak self] title in
                guard let title else { throw EditError.nilText }
                guard let self else { throw EditError.nilViewModel }
                
                self.title = title
                
                return true
            }
        
        let bodyPublisher = input.bodyTextEvent
            .tryMap { [weak self] body in
                guard let body else { throw EditError.nilText }
                guard let self else { throw EditError.nilViewModel }
                
                self.body = body
                
                return true
            }
        
        let datePublisher = input.datePickerEvent
            .tryMap { [weak self] date in
                guard let self else { throw EditError.nilViewModel}
                
                self.date = date
                
                return true
            }
        
        let isEditingDone = titlePublisher
            .merge(with: bodyPublisher, datePublisher)
            .eraseToAnyPublisher()
        
        return Output(isEditingDone: isEditingDone)
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
