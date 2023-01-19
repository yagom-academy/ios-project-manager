//
//  TaskListViewModelTests.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/18.
//

import XCTest

import RxSwift
import RxTest

final class TaskListViewModelTests: XCTestCase {
    var viewModel: TaskListViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var input: TaskListViewModel.Input!
    
    override func setUpWithError() throws {
        viewModel = TaskListViewModel(
            fetchTasksUseCase: FetchTasksUseCaseMock(),
            deleteTaskUseCase: DeleteTaskUseCaseMock()
        )
        
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    func test_viewWillAppearEvent_received() {
        // given
        let viewWillAppearEventObserver = scheduler.createHotObservable([
            .next(10, ())
        ])
        
        let isEmptyObserver = scheduler.createObserver(Bool.self)
        
        input = TaskListViewModel.Input(
            viewWillAppearEvent: viewWillAppearEventObserver.asObservable(),
            createButtonTapEvent: Observable.empty(),
            indexPathToDelete: Observable.empty(),
            indexPathToLongPress: Observable.empty(),
            selectedTaskEvent: Observable.empty()
        )
        
        // when
        viewModel.bind(with: input)
        viewModel.tasks
            .subscribe(onNext: { tasks in
                isEmptyObserver.on(.next(tasks.isEmpty))
            })
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
        XCTAssertEqual(isEmptyObserver.events, [
            .next(0, true),
            .next(10, false)
        ])
    }
}
