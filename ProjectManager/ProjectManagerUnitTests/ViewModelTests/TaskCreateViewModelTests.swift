//
//  TaskCreateViewModelTests.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/18.
//

import XCTest

import RxSwift
import RxTest

final class TaskCreateViewModelTests: XCTestCase {
    var viewModel: TaskCreateViewModel!
    var disposeBag: DisposeBag!
    var input: TaskCreateViewModel.Input!
    var output: TaskCreateViewModel.Output!
    var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        viewModel = TaskCreateViewModel(createTaskUseCase: CreateTaskUseCaseMock())
        
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    func test_title_content_bind_success() {
        // given
        let titleDidEditEvent = scheduler.createHotObservable([
            .next(10, "TestTitle"),
            .next(20, ""),
            .next(30, "TestTitle2"),
            .next(40, "")
        ])
        let contentDidEditEvent = scheduler.createHotObservable([
            .next(15, "testContent"),
            .next(25, "testContent2"),
            .next(35, "")
        ])
        let datePickerDidEditEvent = scheduler.createHotObservable([
            .next(0, Date())
        ])
        
        input = TaskCreateViewModel.Input(
            titleDidEditEvent: titleDidEditEvent.asObservable(),
            contentDidEditEvent: contentDidEditEvent.asObservable(),
            datePickerDidEditEvent: datePickerDidEditEvent.asObservable(),
            doneButtonTapEvent: Observable.empty()
        )
        
        // when
        let isFillObserver = scheduler.createObserver(Bool.self)
        
        viewModel.transform(from: input)
            .isFill
            .subscribe(isFillObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
        XCTAssertEqual(isFillObserver.events, [
            .next(15, true),
            .next(20, false),
            .next(25, false),
            .next(30, true),
            .next(35, false),
            .next(40, false)
        ])
    }
    
    func test_tappedDoneButton_success() {
        // given
        let doneButtonTapObserver = scheduler.createHotObservable([
            .next(0, ()),
            .next(10, ()),
            .next(50, ())
        ])
        
        input = TaskCreateViewModel.Input(
            titleDidEditEvent: Observable.empty(),
            contentDidEditEvent: Observable.empty(),
            datePickerDidEditEvent: Observable.just(Date()),
            doneButtonTapEvent: doneButtonTapObserver.asObservable()
        )
        
        // when
        let tappedDoneButton = scheduler.createObserver(Bool.self)
        
        viewModel.transform(from: input)
            .isSuccess
            .subscribe(tappedDoneButton)
            .disposed(by: disposeBag)
        
        scheduler.start()
        // then
        
        XCTAssertEqual(tappedDoneButton.events, [
            .next(0, true),
            .next(10, true),
            .next(50, true),
        ])
    }
}
