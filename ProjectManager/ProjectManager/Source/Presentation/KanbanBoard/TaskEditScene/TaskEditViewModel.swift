//
//  ViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import RxRelay
import RxSwift

// task 받기
final class TaskEditViewModel {
    let updateTaskUseCase: UpdateTaskUseCase
    
    private var title: String = ""
    private var content: String = ""
    private var date: Double = 0
    
    init(updateTaskUseCase: UpdateTaskUseCase) {
        self.updateTaskUseCase = updateTaskUseCase
    }
    
    // MARK: - Output
    struct Output {
        let isSuccess = PublishRelay<Bool>()
    }
    
    // MARK: - Input
    struct Input {
        let titleDidEditEvent: Observable<String>
        let contentDidEditEvent: Observable<String>
        let datePickerDidEditEvent: Observable<Double>
        let doneButtonTapEvent: Observable<Void>
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        return output
    }
}
