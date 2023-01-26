//
//  ListFormViewModelTests.swift
//  ProjectManagerTests
//  Created by inho on 2023/01/19.
//

import XCTest
@testable import ProjectManager

final class ListFormViewModelTests: XCTestCase {
    var sut: ListFormViewModel!
    let testIndex: Int = 0
    let testItem = ListItem(title: "Test title", body: "Test body", dueDate: Date())
    let testType: ListType = .todo
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = ListFormViewModel(index: testIndex, listItem: testItem, listType: testType)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }

    func test_edit버튼누를시_편집모드가활성화되는가() {
        //given
        //when
        sut.toggleEditMode()
        
        //then
        XCTAssertTrue(sut.isEditable)
    }
}
