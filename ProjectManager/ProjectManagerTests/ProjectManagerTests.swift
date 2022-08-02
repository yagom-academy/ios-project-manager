//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by Tiana, mmim on 2022/07/29.
//

import XCTest
@testable import ProjectManager

class ProjectManagerTests: XCTestCase {
    
    var sut: ProjectUseCase!
    var persistentManager: MockPersistentManager!
    var networkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        persistentManager = MockPersistentManager()
        networkManager = MockNetworkManager()
        
        sut = DefaultProjectUseCase(
            projectRepository: PersistentRepository(persistentManager: persistentManager),
            networkRepository: NetworkRepository(networkManger: networkManager),
            historyRepository: HistoryRepository(historyManager: HistoryManager())
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_create() {
        // given
        let data = ProjectEntity(title: "test", deadline: Date(), body: "test_body")
        
        // when
        sut.create(projectEntity: data)
        
        // then
        XCTAssertEqual(persistentManager.database.projects.first!.id, data.id.uuidString)
    }
    
    func test_read_all() {
        // given
        let dataToCreate = ProjectEntity(title: "test", deadline: Date(), body: "test_body")
        sut.create(projectEntity: dataToCreate)
        
        // when
        let data = sut.read()
        
        // then
        XCTAssertEqual(data.value.first!.id, dataToCreate.id)
    }
    
    func test_read_with_id() {
        // given
        let dataToCreate = ProjectEntity(title: "test", deadline: Date(), body: "test_body")
        sut.create(projectEntity: dataToCreate)
        
        // when
        let data = sut.read(projectEntityID: dataToCreate.id)
        
        // then
        XCTAssertEqual(data!.title, dataToCreate.title)
    }
    
    func test_update() {
        // given
        let dataToCreate = ProjectEntity(title: "test", deadline: Date(), body: "test_body")
        sut.create(projectEntity: dataToCreate)
        
        // when
        let dataToUpdate = ProjectEntity(id: dataToCreate.id, title: "upateTest", deadline: Date(), body: "test_body")
        sut.update(projectEntity: dataToUpdate)
        
        // then
        XCTAssertEqual(persistentManager.database.projects.first!.title, dataToUpdate.title)
        XCTAssertEqual(persistentManager.database.projects.first!.body, dataToUpdate.body)
    }
    
    func test_delete() {
        // given
        let firstDataToCreate = ProjectEntity(title: "test1", deadline: Date(), body: "test_body1")
        let secondDataToCreate = ProjectEntity(title: "test2", deadline: Date(), body: "test_body2")
        sut.create(projectEntity: firstDataToCreate)
        sut.create(projectEntity: secondDataToCreate)
        
        // when
        sut.delete(projectEntityID: firstDataToCreate.id)
        
        // then
        XCTAssertEqual(persistentManager.database.projects.count, 1)
        XCTAssertEqual(persistentManager.database.projects.first!.id, secondDataToCreate.id.uuidString)
    }
}
