//
//  UndoRedoManager.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/08/01.
//

import RxCocoa
import RxSwift

class UndoRedoManager {
    let undoRelay = PublishRelay<Void>()
    let redoRelay = PublishRelay<Void>()
    
    private var undoStack: [History] = []
    private var redoStack: [History] = []
    private let disposeBag = DisposeBag()
    
    private let database: DatabaseManagerProtocol
    private let undoRedoActionAble: UndoRedoActionAble
    
    init(database: DatabaseManagerProtocol) {
        self.database = database
        self.undoRedoActionAble = UndoRedoActionAble(database: database)
        self.bind()
    }

    func bind() {
        self.database.historyBehaviorRelay
            .subscribe(onNext: { [weak self] history in
                self?.undoStack = history
            })
            .disposed(by: self.disposeBag)
        
        self.undoRelay
            .subscribe(onNext: { [weak self] _ in
                guard let lastHistory = self?.undoStack.removeLast() else { return }
                self?.undoRedoActionAble.undoTapEvent(history: lastHistory)
                self?.redoStack.append(lastHistory)
            })
            .disposed(by: self.disposeBag)

        self.redoRelay
            .subscribe(onNext: { [weak self] _ in
                guard let lastHistory = self?.redoStack.removeLast() else { return }
                self?.undoRedoActionAble.redoTapEvent(history: lastHistory)
            })
            .disposed(by: self.disposeBag)
    }
    
    func isRedo() -> Observable<Bool> {
        return Observable.create { observer in
            let _ = Observable.of(self.undoRelay, self.redoRelay)
                .merge()
                .subscribe(onNext: { [weak self] _ in
                    if self?.redoStack.count == 0 {
                        observer.onNext(false)
                    } else {
                        observer.onNext(true)
                    }
                })
            return Disposables.create()
        }
    }
}

class UndoRedoActionAble {
    let database: DatabaseManagerProtocol
    
    init(database: DatabaseManagerProtocol) {
        self.database = database
    }
    
    func undoTapEvent(history: History) {
        switch history.action {
        case .moved:
            self.database.update(selectedTodo: history.previousTodo ?? history.nextTodo)
        case .added:
            self.database.delete(todoID: history.identifier)
        case .edited:
            self.database.update(selectedTodo: history.previousTodo ?? history.nextTodo)
        case .removed:
            self.database.create(todoData: history.nextTodo)
        }
        
        self.database.deleteHistory()
    }
    
    func redoTapEvent(history: History) {
        switch history.action {
        case .moved:
            self.database.update(selectedTodo: history.nextTodo)
        case .added:
            self.database.create(todoData: history.nextTodo)
        case .edited:
            self.database.update(selectedTodo: history.nextTodo)
        case .removed:
            self.database.delete(todoID: history.identifier)
        }
    }
}
