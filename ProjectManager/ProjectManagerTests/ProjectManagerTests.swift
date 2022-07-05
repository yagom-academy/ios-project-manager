//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import XCTest

@testable import ProjectManager

class ProjectManagerTests: XCTestCase {

    var projectManager: ProjectManager!
    override func setUpWithError() throws {
        projectManager = ProjectManager(realmManager: RealmManager())
    }

    override func tearDownWithError() throws {
        try projectManager.deleteAll()
        projectManager = nil
    }

    func test_Create() throws {
        let project = Project(title: "샘플입니당", date: Date(), body: "바디입니다")
        try projectManager.create(project: project)
        let result = projectManager.read(id: project.id)
        XCTAssertEqual(project, result)
    }
    
    func test_remove() {
        do {
            let project = Project(title: "삭제 테스트", date: Date(), body: "삭제바디입니다")
            let id = project.id
            try projectManager.create(project: project)
            try projectManager.delete(project: project)
            let data = projectManager.read(id: id)
            XCTAssertNil(data)
        } catch {
            XCTFail()
        }
    }
    func test_update() {
        do {
            let updateTitle = "업데이트 성공!"
            let project = Project(title: "업데이트", date: Date(), body: "바디바디")
            let id = project.id
            try projectManager.create(project: project)
            let updateData = Project(id: id, title: updateTitle, date: project.date, body: project.body)
            try projectManager.update(project: updateData)
            let value = projectManager.read(id: project.id)
            XCTAssertEqual(value?.title, updateTitle)
            XCTAssertEqual(project, value)
        } catch {
            XCTFail()
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
