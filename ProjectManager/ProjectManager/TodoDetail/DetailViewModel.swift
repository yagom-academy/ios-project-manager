//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import Foundation

import RxCocoa
import RxSwift

final class DetailViewModel {
    struct Input {
        let doneButtonTapEvent: Observable<Todo>
    }
    
    struct Output {
        let dismiss: Driver<Void>
    }
    
    private var dataBase: DataBase
    
    init(dataBase: DataBase) {
        self.dataBase = dataBase
    }
    
    func transform(input: Input) -> Output {
        let output = input.doneButtonTapEvent
            .do { self.dataBase.save(todoListData: [$0]) }
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
        
        return Output(dismiss: output)
    }
}
