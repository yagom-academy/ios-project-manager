//
//  WorkViewModel.swift
//  ProjectManager
//
//  Created by BMO on 2023/10/01.
//

import Foundation

final class WorkViewModel {
    // Closure를 이용하는 방법
//    var didChangeWorks: ((WorkViewModel) -> Void)?
//
//    var works: [Work] {
//        didSet {
//            didChangeWorks?(self)
//        }
//    }
//
//    init() {
//        works = (1...10).map {
//            Work(title: "\($0) 번째", description: "\($0) 번째 일 설명", deadline: Date())
//        }
//    }
//
//    func updateWorks(_ works: [Work]) {
//        self.works = works
//    }
    
    // Observable을 이용하는 방법
    var works: Observable<[Work]> = Observable([])
    
    init() {
        works.value = (1...10).map {
            Work(title: "\($0) 번째", description: "\($0) 번째 일 설명", deadline: Date())
        }
    }
    
    func updateWorks(_ works: [Work]) {
        self.works.value = works
    }
}
