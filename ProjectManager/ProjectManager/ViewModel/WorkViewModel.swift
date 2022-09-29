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
    
    func createWork(_ id: UUID, _ title: String, _ content: String, _ deadline: Date, _ state: WorkState) {
        let work = Work(id: id, title: title, content: content, deadline: deadline, state: state)
        
        newWork.onNext(work)
    }
    
    private func fetchWork() {
        database.fetchWork()
            .subscribe(onNext: works.onNext)
            .disposed(by: disposeBag)
    }
    
    func addWork() {
        newWork
            .take(1)
            .subscribe(onNext: { self.database.saveWork($0) })
            .disposed(by: disposeBag)
        
        fetchWork()
        updateHistory(type: .add)
    }
    
    func editWork() {
        newWork
            .take(1)
            .subscribe(onNext: { self.database.saveWork($0) })
            .disposed(by: disposeBag)

        fetchWork()
        updateHistory(type: .edit)
    }
    
    func deleteWork(id: UUID) {
        database.deleteWork(id: id)
        
        fetchWork()
        updateHistory(type: .delete)
    }
    
    func changeWorkState(_ work: Work, to state: WorkState) {
        let changedWork = Work(id: work.id,
                               title: work.title,
                               content: work.content,
                               deadline: work.deadline,
                               state: state)
        
        database.saveWork(changedWork)
        fetchWork()
        
        histories
            .take(1)
            .subscribe(onNext: {
            self.histories.onNext(["Moved '\(work.title)' from \(work.state.rawValue) to \(state.rawValue)."] + $0)
        }).disposed(by: disposeBag)
    }
    
    private func updateHistory(type: HistoryType) {
        guard let work = try? newWork.value() else { return }
        
        histories
            .take(1)
            .subscribe(onNext: {
                self.histories.onNext(["\(type.rawValue) '\(work.title)'."] + $0)
            }).disposed(by: disposeBag)
    }
}

extension WorkViewModel {
    private enum HistoryType: String {
        case add = "Added"
        case edit = "Edited"
        case delete = "Removed"
        case move = "Moved"
    }
}
