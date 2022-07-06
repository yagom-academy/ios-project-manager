//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 김태현 on 2022/07/06.
//

import RxSwift
import RxRelay

class MainViewModel {
    struct Input {
        let saveButtonTapEvent: Observable<Void>
        let cellTapEvent: Observable<IndexPath>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
