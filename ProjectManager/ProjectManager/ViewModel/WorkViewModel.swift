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
    private let works = BehaviorSubject<[Work]>(value: [])
    let worksObservable: Observable<[Work]>
    
    init() {
        works.onNext(SampleData.todoWorks + SampleData.doingWorks + SampleData.doneWorks)
        worksObservable = works
    }
    
    func selectWork(by index: Int, _ state: WorkState) -> Work {
        let stateWorks = works.value.filter {
            $0.state == state
        }
        
        return stateWorks[index]
    func addWork(_ work: Work) {
        guard let value = try? works.value() else { return }
        
        works.onNext([work] + value)
    }
    
    func editWork(_ work: Work, newWork: Work) {
        works.map {
            $0.map {
                return $0.id == work.id ? newWork : $0
            }
        }.observe(on: MainScheduler.asyncInstance)
            .take(1)
            .subscribe(onNext: {
                self.works.onNext($0)
            }).disposed(by: disposeBag)
    }
    
    func deleteWork(_ work: Work) {
        works.map {
            $0.filter { $0.id != work.id }
        }
        .take(1)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: {
            self.works.onNext($0)
        }).disposed(by: disposeBag)
    }
    
    func chnageWorkState(_ work: Work, to state: WorkState) {
        deleteWork(work)

        let changedWork = Work(id: work.id,
                               title: work.title,
                               content: work.content,
                               deadline: work.deadline,
                               state: state)
        
        works.onNext(value + [changedWork])
    }
}
