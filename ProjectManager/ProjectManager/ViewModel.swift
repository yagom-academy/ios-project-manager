//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import Foundation
import RxSwift

final class ViewModel {
    struct Input {
        let buttonTapEvent: Observable<Void>
    }
    
    struct Output {
        let tableViewData: BehaviorSubject<[Todo]>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(tableViewData: BehaviorSubject<[Todo]>(value: [Todo]()))
    }
}
