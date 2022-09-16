//
//  WorkViewModel.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/07.
//

import RxSwift
import RxCocoa

class WorkViewModel {
    private let disposeBag = DisposeBag()
    let works = BehaviorRelay<[Work]>(value: [])
    
    init() {
        works.accept(SampleData.todoWorks + SampleData.doingWorks + SampleData.doneWorks)
    }
    
    func selectWork(by index: Int, _ state: WorkState) -> Work {
        let stateWorks = works.value.filter {
            $0.state == state
        }
        
        return stateWorks[index]
    }
    
    func deleteWork(_ work: Work) {
        works.map {
            $0.filter { $0.id != work.id }
        }
        .take(1)
        .observe(on: MainScheduler.instance)
        .bind(to: works)
        .disposed(by: disposeBag)
    }
    
    func chnageWorkState(_ work: Work, to state: WorkState) {
        
        works.map {
            $0.map {
                if $0.id == work.id {
                    return Work(id: $0.id, title: $0.title, content: $0.content, deadline: $0.deadline, state: state)
                } else {
                    return $0
                }
            }
        }
        .take(1)
        .observe(on: MainScheduler.instance)
        .bind(to: works)
        .disposed(by: disposeBag)
    }
}
