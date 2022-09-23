//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/16.
//

import RxSwift

final class TodoViewModel: CellViewModelType {
    
    // MARK: - Properties
    
    var provider = TodoDataProvider.shared
    var statusType: TodoStatus?
    var disposeBag = DisposeBag()
}
