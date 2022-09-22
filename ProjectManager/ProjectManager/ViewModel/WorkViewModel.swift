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
    
    func selectWork(id: UUID) -> Work? {
        guard let value = try? works.value() else { return nil }
        
        let selectedWork = value.filter {
            $0.id == id
        }
        
        return selectedWork.first
    }
    
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
    
    func deleteWork(id: UUID) {
        works.map {
            $0.filter { $0.id != id }
        }
        .take(1)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: {
            self.works.onNext($0)
        }).disposed(by: disposeBag)
    }
    
    func changeWorkState(_ work: Work, to state: WorkState) {
        let changedWork = Work(id: work.id,
                               title: work.title,
                               content: work.content,
                               deadline: work.deadline,
                               state: state)

        works.map {
            $0.map {
                $0.id == work.id ? changedWork : $0
            }
        }.take(1)
        .observe(on: MainScheduler.asyncInstance)
        .subscribe(onNext: {
            self.works.onNext($0)
        }).disposed(by: disposeBag)
    }
}
