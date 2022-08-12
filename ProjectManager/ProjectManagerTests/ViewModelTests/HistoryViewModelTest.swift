//
//  HistoryViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/27.
//

import XCTest
import RxSwift
@testable import ProjectManager

class HistoryViewModelTest: XCTestCase {
    var useCase: MockUseCase!
    var viewModel: DefaultTodoHistoryViewModel!
    let bag = DisposeBag()
    let dummyData: [History] = [.init(changes: .added, title: "todo"),
                                .init(changes: .moved, title: "doing", beforeState: .todo, afterState: .doing),
                                .init(changes: .removed, title: "done")]
    
    override func setUpWithError() throws {
        useCase = .init()
        viewModel = .init(useCase: useCase)
    }

    override func tearDownWithError() throws {
        useCase = nil
        viewModel = nil
    }
    
    func test_UseCase를_통해_HistoryItme을_읽어오는지() {
        // given
        useCase.historyList.onNext(dummyData)
        
        // when
        viewModel.historyList
            .bind { cellItems in
                // then
                XCTAssertEqual(cellItems.count, self.dummyData.count)
            }.disposed(by: bag)
    }
}
