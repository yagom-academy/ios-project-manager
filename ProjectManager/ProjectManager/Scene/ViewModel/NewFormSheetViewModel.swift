//
//  NewFormSheetViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxSwift
import RxRelay

protocol FormSheetViewModelInput {
    func doneButtonTapped()
}

protocol FormSheetViewModelOutput {
    var title: BehaviorRelay<String> { get }
    var body: BehaviorRelay<String> { get }
    var date: BehaviorRelay<Double> { get }
    var dismiss: PublishRelay<Void> { get }
}

final class NewFormSheetViewModel: FormSheetViewModelInput, FormSheetViewModelOutput {
    
    var title: BehaviorRelay<String> = BehaviorRelay(value: "")
    var body: BehaviorRelay<String> = BehaviorRelay(value: "")
    var date: BehaviorRelay<Double> = BehaviorRelay(value: .zero)
    var dismiss: PublishRelay<Void> = .init()
    
    private let realmManager = RealmManager()
    private let uuid = UUID().uuidString
    
    func doneButtonTapped() {
        saveToTempModel()
        dismiss.accept(())
    }
    
    private func saveToTempModel() {
        let newProject = Task(
            title: title.value,
            body: body.value,
            date: date.value,
            taskType: .todo,
            id: uuid
        )
        realmManager.create(task: newProject)
    }
}
