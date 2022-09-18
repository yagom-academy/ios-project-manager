//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/17.
//

import RxSwift

final class DoneViewModel: CellViewModelType {
    
    // MARK: - Properties

    var statusType: TodoStatus?
    
    var mainViewModel: ProjectManagerViewModelType?
    
    var saveSubject = PublishSubject<Todo?>()
    var deleteSubject = PublishSubject<Todo>()
    var moveToSubject = PublishSubject<Todo>()
    
    var modelOutput: ProjectManagerModelOutput?
    var disposeBag = DisposeBag()
}
