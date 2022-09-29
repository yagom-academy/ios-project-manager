//
//  WorkViewModel.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/07.
//

import RxSwift
import RxCocoa

final class WorkViewModel {
    private var database: DatabaseManageable
    private let disposeBag = DisposeBag()
    private let works = BehaviorSubject<[Work]>(value: [])
    private let histories = BehaviorSubject<[String]>(value: [])
    let worksObservable: Observable<[Work]>
    let historiesObservable: Observable<[String]>
    let newWork = BehaviorSubject<Work>(value: Work(id: UUID(), title: "", content: "", deadline: Date(), state: .todo))
    
    init(dbType: DatabaseManageable) {
        database = dbType
        
        database.fetchWork()
            .subscribe(onNext: works.onNext)
            .disposed(by: disposeBag)
        
        worksObservable = works
        historiesObservable = histories
    }
    
    func changeDatabase(_ isConnected: Bool) {
        if isConnected {
            database = FirebaseManager.shared
            backupWorks()
        } else {
            database = CoreDataManager.shared
        }
    }
    
    private func backupWorks() {
        CoreDataManager.shared.fetchWork()
            .subscribe(onNext: {
                $0.forEach {
                    FirebaseManager.shared.saveWork($0)
                    CoreDataManager.shared.deleteWork(id: $0.id)
                }
            }).disposed(by: disposeBag)
    }
    
    func selectWork(id: UUID) -> Work? {
        guard let value = try? works.value() else { return nil }
        
        let selectedWork = value.filter {
            $0.id == id
        }
        
        return selectedWork.first
    }
    
    func addWork(_ work: Work) {
        database.saveWork(work)
        guard let value = try? works.value() else { return }
    func createWork(_ id: UUID, _ title: String, _ content: String, _ deadline: Date, _ state: WorkState) {
        let work = Work(id: id, title: title, content: content, deadline: deadline, state: state)
        
        works.onNext([work] + value)
        
        histories
            .take(1)
            .observe(on: MainScheduler.instance)
            .subscribe {
            self.histories.onNext(["Added '\(work.title)'."] + $0)
        }.disposed(by: disposeBag)
    }
    
    func editWork(_ work: Work, newWork: Work) {
        database.saveWork(newWork)
        
        works.map {
            $0.map {
                return $0.id == work.id ? newWork : $0
            }
        }.observe(on: MainScheduler.asyncInstance)
            .take(1)
            .subscribe(onNext: {
                self.works.onNext($0)
            }).disposed(by: disposeBag)

        histories.take(1)
            .observe(on: MainScheduler.instance)
            .subscribe {
            self.histories.onNext(["Edited '\(work.title)'."] + $0)
        }.disposed(by: disposeBag)
    }
    
    func deleteWork(id: UUID) {
        database.deleteWork(id: id)
        
        works.map {
            $0.filter { $0.id != id }
        }
        .take(1)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: {
            self.works.onNext($0)
        }).disposed(by: disposeBag)
        
        guard let work = selectWork(id: id) else { return }
        
        histories.take(1)
            .observe(on: MainScheduler.instance)
            .subscribe {
            self.histories.onNext(["Removed '\(work.title)'."] + $0)
        }.disposed(by: disposeBag)
    }
    
    func changeWorkState(_ work: Work, to state: WorkState) {
        let changedWork = Work(id: work.id,
                               title: work.title,
                               content: work.content,
                               deadline: work.deadline,
                               state: state)
        
        database.saveWork(changedWork)
        
        works.map {
            $0.map {
                $0.id == work.id ? changedWork : $0
            }
        }.take(1)
        .observe(on: MainScheduler.asyncInstance)
        .subscribe(onNext: {
            self.works.onNext($0)
        }).disposed(by: disposeBag)
        
        histories
            .take(1)
            .observe(on: MainScheduler.instance)
            .subscribe {
            self.histories.onNext(["Moved '\(work.title)' from \(work.state.rawValue) to \(state.rawValue)."] + $0)
        }.disposed(by: disposeBag)
    }
}
