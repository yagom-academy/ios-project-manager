//
//  RealmManagerTests.swift
//  ProjectManagerTests
//
//  Created by JeongTaek Han on 2022/03/16.
//

import XCTest
@testable import ProjectManager

final class RealmManagerTests: XCTestCase {
    
    private var sutRealmManager: RealmManager<RealmTask>!

    override func setUpWithError() throws {
        self.sutRealmManager = RealmManager()
    }

    override func tearDownWithError() throws {
        try? self.sutRealmManager.removeAll()
        self.sutRealmManager = nil
    }

    private func testExample() throws {
        // given
        let task = RealmTask(id: UUID(), title: "Hello", description: "World", dueDate: Date(), status: 0)
        try? self.sutRealmManager.create(task)
        
        // when
        guard let result = try? self.sutRealmManager.fetch().first else {
            XCTFail()
            return
        }
        
        print(result)
        
        // then
        XCTAssertEqual(result, task)
    }

}
