//
//  TaskEditViewModelTests.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/18.
//

import XCTest

import RxSwift
import RxTest

final class TaskEditViewModelTests: XCTestCase {
    private var viewModel: TaskEditViewModel!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: TaskEditViewModel.Input!
    private var output: TaskEditViewModel.Output!
    private var updateTaskUseCase: UpdateTaskUseCaseMock!

    override func setUpWithError() throws {
        updateTaskUseCase = UpdateTaskUseCaseMock()
        viewModel = TaskEditViewModel(task: TaskDummy.dummys[0],
                                      updateTaskUseCase: updateTaskUseCase)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        updateTaskUseCase = nil
        disposeBag = nil
        scheduler = nil
    }

    func test_is_fill() {
        let titleDidEditEventTestable = scheduler.createHotObservable([
            .next(0, ""),
            .next(10, "A"),
            .next(20, ""),
            .next(30, "C")
        ])
        
        let contentDidEditEventTestable = scheduler.createHotObservable([
            .next(0, ""),
            .next(15, "AB"),
            .next(25, ""),
            .next(35, "CD")
        ])
        
        let isFillObserver = scheduler.createObserver(Bool.self)
        
        input = TaskEditViewModel.Input(titleDidEditEvent: titleDidEditEventTestable.asObservable(),
                                        contentDidEditEvent: contentDidEditEventTestable.asObservable(),
                                        datePickerDidEditEvent: Observable.just(Date()),
                                        doneButtonTapEvent: Observable.just(()))
        
        let output = viewModel.transform(from: input)
        output.isFill
            .subscribe(isFillObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isFillObserver.events,
                       [.next(0, false),
                        .next(10, false),
                        .next(15, true),
                        .next(20, false),
                        .next(25, false),
                        .next(30, false),
                        .next(35, true)])
    }
    
    func test_tap_edit_button() {
        let editButtonDidTapTestable = scheduler.createHotObservable([
            .next(0, ()),
            .next(10, ())
        ])
        
        let isUpdatedObserver = scheduler.createObserver(Bool.self)
        
        input = TaskEditViewModel.Input(titleDidEditEvent: Observable.just(""),
                                        contentDidEditEvent: Observable.just(""),
                                        datePickerDidEditEvent: Observable.just(Date()),
                                        doneButtonTapEvent: editButtonDidTapTestable.asObservable())
        
        let output = viewModel.transform(from: input)
        output.isSuccess
            .subscribe(isUpdatedObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isUpdatedObserver.events,
                       [.next(0, true),
                        .next(10, true)])
    }
}
