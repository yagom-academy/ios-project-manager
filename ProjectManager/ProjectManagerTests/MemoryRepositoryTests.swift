import XCTest

class MemoryRepositoryTests: XCTestCase {
    
    var sut = MemoryRepository()

    func test_creat() {
        // given
        let project = Project(title: "d", description: "d", date: Date())
        
        // when
        sut.create(project) { project in
            
            // then
            XCTAssertNotNil(project)
        }
    }

    func test_update() {
        // given
        let project = Project(id: UUID(), title: "d", description: "d", date: Date(), status: .todo)
        sut.create(project)
        let new = Project(id: project.id, title: "asd", description: "asd", date: Date(), status: .doing)
        
        // when
        sut.update(with: new) { item in
            
            // then
            XCTAssertNotNil(item)
            XCTAssertTrue(item?.title == "asd")
            XCTAssertTrue(item?.status == .doing)
        }
    }
    
    func test_update_failed() {
        // given
        let project = Project(id: UUID(), title: "d", description: "d", date: Date(), status: .todo)
        sut.create(project)
        let new = Project(id:  UUID(), title: "asd", description: "asd", date: Date(), status: .doing)
        
        // when
        sut.update(with: new) { item in
            
            // then
            XCTAssertNil(item)
        }
    }
    
    func test_delete() {
        // given
        let project = Project(id: UUID(), title: "d", description: "d", date: Date(), status: .todo)
        sut.create(project)
        
        // when
        sut.delete(project) { item in
            // then
            XCTAssertNotNil(item)
            XCTAssertTrue(item?.description == "d")
        }
    }
    
    func test_delete_failed() {
        // given
        let project = Project(id: UUID(), title: "d", description: "d", date: Date(), status: .todo)
        
        // when
        sut.delete(project) { item in
            // then
            XCTAssertNil(item)
        }
    }
}
