//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/17.
//

import RxSwift

final class DoneViewModel: CellViewModelType {
    
    // MARK: - Properties

    var provider = TodoDataProvider.shared
    var statusType: TodoStatus?
    var disposeBag = DisposeBag()
}
