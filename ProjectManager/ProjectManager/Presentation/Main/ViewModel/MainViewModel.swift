//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/06.
//

import RxSwift
import RxRelay

class MainViewModel {
    let toDoTableProjects = BehaviorRelay<[ProjectContents]>(value: [])
    let totalCount: Observable<String>
    let disposeBag = DisposeBag()
    
    init() {
        self.totalCount = toDoTableProjects
            .map { projectContents in
                projectContents.count
            }
            .map { String($0) }
    }
    
    struct Input {
        let cellTapEvent: Observable<IndexPath>
    }
    
    struct Output {
        let content: Observable<ProjectContents?>
    }
    
    func transform(input: Input) -> Output {
        let content = input.cellTapEvent
            .map { [weak self] indexPath -> ProjectContents? in
                guard let content = self?.toDoTableProjects.value[safe: indexPath.row] else {
                    return nil
                }
                
                return content
            }
        
        return Output(content: content)
    }
}

private extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
