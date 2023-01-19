//
//  ListItemCellViewModelTests.swift
//  ProjectManagerTests//  ProjectManagerTests
//  Created by inho on 2023/01/19.
//

import XCTest
@testable import ProjectManager

final class ListItemCellViewModelTests: XCTestCase {
    var sut: ListItemCellViewModel!
    let testItem = ListItem(title: "Test title", body: "Test body", dueDate: Date())
    let testType: ListType = .todo
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = ListItemCellViewModel(listItem: testItem, listType: testType)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }

    func test_아이템을업데이트할때_변경이반영되는가() {
        //given
        let updatedItem = ListItem(title: "Updated title", body: "Updated body", dueDate: Date())
        
        //when
        sut.updateData(using: updatedItem)
        
        //then
        XCTAssertEqual(sut.currentItem.title, updatedItem.title)
        XCTAssertEqual(sut.currentItem.body, updatedItem.body)
        XCTAssertNotEqual(sut.currentItem.title, testItem.title)
        XCTAssertNotEqual(sut.currentItem.body, testItem.body)
    }
    
    func test_아이템의ListType을변경할때_변경이반영되는가() {
        //given
        let newType: ListType = .doing
        
        //when
        sut.moveType(to: newType)
        
        //then
        XCTAssertEqual(sut.listType, newType)
        XCTAssertNotEqual(sut.listType, testType)
    }

}
