//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by Tiana, mmim on 2022/07/29.
//

import XCTest
@testable import ProjectManager
import RxRelay

class ProjectManagerTests: XCTestCase {
    
    var sut: ProjectUseCase!
    var persistentManager: MockPersistentManager!
    var networkManager: MockNetworkManager!
    var mockHistory: MockHistoryManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        persistentManager = MockPersistentManager()
        networkManager = MockNetworkManager()
        mockHistory = MockHistoryManager()
        
        let mockPersistentRepository = PersistentRepository(
            projectEntities: BehaviorRelay<[ProjectEntity]>(value: []),
            persistentManager: persistentManager
        )
        
        sut = DefaultProjectUseCase(
            projectRepository: mockPersistentRepository,
            networkRepository: NetworkRepository(networkManger: networkManager),
            historyRepository: HistoryRepository(historyManager: mockHistory)
        )
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_create_데이터넣으면_locaolDB에_저장되는지() {
        // given
        let data = ProjectEntity(title: "test", deadline: Date(), body: "test_body")
        
        // when
        sut.create(projectEntity: data)
        
        // then
        XCTAssertEqual(persistentManager.database.projects.first!.id, data.id.uuidString)
    }
    
    func test_read_하면_locaolDB의_전체_데이터가_나오는지() {
        // given
        let dataToCreate = ProjectEntity(title: "test", deadline: Date(), body: "test_body")
        sut.create(projectEntity: dataToCreate)
        
        // when
        let data = sut.read()
        
        // then
        XCTAssertEqual(data.value.count, 1)
        XCTAssertEqual(data.value.first!.id, dataToCreate.id)
    }
    
    func test_read_id로_읽으면_해당_데이터가_나오는지() {
        // given
        let dataToCreate = ProjectEntity(title: "test", deadline: Date(), body: "test_body")
        sut.create(projectEntity: dataToCreate)
        
        // when
        let data = sut.read(projectEntityID: dataToCreate.id)
        
        // then
        XCTAssertEqual(data!.title, dataToCreate.title)
    }
    
    func test_update_데이터넣으면_locaolDB에서_해당_데이터가_수정되는지() {
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
    
    func test_delete_ID넣으면_locaolDB에서_해당_데이터가_제거되는지() {
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
    
    func test_load_하면_remoetDB의_전체_데이터가_localDB에_저장되는지() {
        // when
        _ = sut.load()
        
        // then
        XCTAssertEqual(persistentManager.database.projects.first!.title, "title111")
    }
    
    func test_backUp_하면_localDB의_데이터가_remoteDB에_저장되는지() {
        // given
        let dataToCreate = ProjectEntity(title: "test", deadline: Date(), body: "test_body")
        sut.create(projectEntity: dataToCreate)
        
        // when
        sut.backUp()
        
        // then
        let data = networkManager.mockFirebase.database[dataToCreate.id.uuidString]
        
        XCTAssertEqual(networkManager.mockFirebase.database.count, 1)
        XCTAssertEqual(data!["title"], "test")
    }
    
    func test_createHistory_HistoryEntity_넣으면_hitory가_저장되는지() {
        // given
        _ = sut.load()
        let data = sut.read().value.first
        
        sut.update(
            projectEntity: ProjectEntity(
                id: data!.id,
                status: ProjectStatus.doing,
                title: data!.title,
                deadline: DateFormatter().formatted(string: data!.deadline)!,
                body: data!.body
            )
        )
        
        // when
        sut.createHistory(
            historyEntity: HistoryEntity(
                editedType: EditedType.move,
                title: data!.title,
                date: DateFormatter().formatted(string: data!.deadline)!.timeIntervalSince1970
            )
        )
        
        // then
        let history = mockHistory.historyEntities
        XCTAssertEqual(history.value.count, 1)
    }
    
    func test_readHistory_하면_hitory의_데이터가_나오는지() {
        // given
        _ = sut.load()
        let data = sut.read().value.first
        
        sut.update(
            projectEntity: ProjectEntity(
                id: data!.id,
                status: ProjectStatus.doing,
                title: data!.title,
                deadline: DateFormatter().formatted(string: data!.deadline)!,
                body: data!.body
            )
        )
        
        sut.createHistory(
            historyEntity: HistoryEntity(
                editedType: EditedType.move,
                title: data!.title,
                date: DateFormatter().formatted(string: data!.deadline)!.timeIntervalSince1970
            )
        )
        
        sut.update(
            projectEntity: ProjectEntity(
                id: data!.id,
                status: ProjectStatus.doing,
                title: "changed",
                deadline: DateFormatter().formatted(string: data!.deadline)!,
                body: data!.body
            )
        )
        
        sut.createHistory(
            historyEntity: HistoryEntity(
                editedType: EditedType.edit,
                title: data!.title,
                date: DateFormatter().formatted(string: data!.deadline)!.timeIntervalSince1970
            )
        )
        
        // when
        _ = sut.readHistory()
        
        // then
        let history = mockHistory.historyEntities
        XCTAssertEqual(history.value.count, 2)
    }
}
