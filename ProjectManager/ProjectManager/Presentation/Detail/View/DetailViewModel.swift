//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import RxSwift
import RxRelay

class DetailViewModel {
    let content: Observable<ProjectContent>
    let disposeBag = DisposeBag()
    
    init(content: ProjectContent) {
        self.content = Observable.just(content)
    }
}
