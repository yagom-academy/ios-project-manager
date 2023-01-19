//
//  StateUpdateViewModelTests.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/18.
//

import XCTest

import RxSwift
import RxTest

final class StateUpdateViewModelTests: XCTestCase {
    private var viewModel: StateUpdateViewModel!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: StateUpdateViewModel.Input!
    private var output: StateUpdateViewModel.Output!
    private var updateTaskUseCase: UpdateTaskUseCaseMock!
    
    override func setUpWithError() throws {
        updateTaskUseCase = UpdateTaskUseCaseMock()
        viewModel = StateUpdateViewModel(updateTaskUseCase: updateTaskUseCase,
                                         task: TaskDummy.dummys[0])
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        updateTaskUseCase = nil
        disposeBag = nil
        scheduler = nil
    }
    
    func test_tap_move_to_todo_button() {
        //current State todo
        let moveToTodoButtonDidTapTestable = scheduler.createHotObservable([
            .next(0, ())
        ])
        
        let isUpdatedObserver = scheduler.createObserver(Bool.self)
        
        input = StateUpdateViewModel.Input(
            moveToTodoButtonTapEvent: moveToTodoButtonDidTapTestable.asObservable(),
            moveToDoingButtonTapEvent: Observable.empty(),
            moveToDoneButtonTapEvent: Observable.empty()
        )
        
        let output = viewModel.transform(from: input)
        output.isSuccess
            .subscribe(isUpdatedObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertTrue(isUpdatedObserver.events.isEmpty)
    }
    
    func test_tap_move_to_doing_button() {
        //current State todo
        let moveToDoingButtonDidTapTestable = scheduler.createHotObservable([
            .next(0, ())
        ])
        
        let isUpdatedObserver = scheduler.createObserver(Bool.self)
        
        input = StateUpdateViewModel.Input(
            moveToTodoButtonTapEvent: Observable.empty(),
            moveToDoingButtonTapEvent: moveToDoingButtonDidTapTestable.asObservable(),
            moveToDoneButtonTapEvent: Observable.empty()
        )
        
        let output = viewModel.transform(from: input)
        output.isSuccess
            .subscribe(isUpdatedObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isUpdatedObserver.events,
                       [.next(0, true)])
    }
    
    func test_tap_move_to_done_button() {
        //current State todo
        let moveToDoneButtonDidTapTestable = scheduler.createHotObservable([
            .next(0, ())
        ])
        
        let isUpdatedObserver = scheduler.createObserver(Bool.self)
        
        input = StateUpdateViewModel.Input(
            moveToTodoButtonTapEvent: Observable.empty(),
            moveToDoingButtonTapEvent: Observable.empty(),
            moveToDoneButtonTapEvent: moveToDoneButtonDidTapTestable.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        output.isSuccess
            .subscribe(isUpdatedObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isUpdatedObserver.events,
                       [.next(0, true)])
    }
}
