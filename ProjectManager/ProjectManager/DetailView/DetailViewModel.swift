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
    }
    
    struct Output {
        let isEditingDone = PassthroughSubject<Bool, Error>()
    }
    
    let mode: Mode
    
    var title: String? = ""
    var body: String? = ""
    var date: Date = Date()
    
    weak var delegate: DetailViewModelDelegate?
    
    private var workState: WorkState = .todo
    private var id: UUID?
    private var cancellables = Set<AnyCancellable>()
    
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
        let output = Output()
        
        input.titleTextEvent
            .sink(receiveValue: { [weak self] title in
                guard let self else { return }
                
                self.title = title
                output.isEditingDone.send(true)
            })
            .store(in: &cancellables)
        
        input.bodyTextEvent
            .sink(receiveValue: { [weak self] body in
                guard let self else { return }
                
                self.body = body
                output.isEditingDone.send(true)
            })
            .store(in: &cancellables)
       
        return output
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
