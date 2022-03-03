import XCTest

class MemoryUseCaseTests: XCTestCase {
    
    var sut = MemoryUseCase()

    func test_create() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        
        // when
        sut.create(project) { item in
            
            // then
            XCTAssertNotNil(item)
            XCTAssertTrue(item?.title == "제목")
        }
        XCTAssertTrue(sut.fetch().count == 1)
    }
    
    func test_create_3() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        
        // when
        sut.create(project, completion: nil)
        sut.create(project, completion: nil)
        sut.create(project, completion: nil)
        
        // then
        XCTAssertTrue(sut.fetch().count == 3)
    }
    
    func test_update() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project, completion: nil)
        let newProject = Project(id: project.id, title: "수정", description: "수정 내용", date: Date(), status: .doing)
        
        // when
        sut.update(newProject) { item in
            
            // then
            XCTAssertNotNil(item)
            XCTAssertTrue(item?.title == "수정")
            XCTAssertTrue(item?.id == project.id)
        }
        XCTAssertTrue(sut.fetch().count == 1)
    }
    
    func test_update_failed() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project, completion: nil)
        let newProject = Project(id: UUID(), title: "수정", description: "수정 내용", date: Date(), status: .doing)
        
        // when
        sut.update(newProject) { item in
            
            // then
            XCTAssertNil(item)
        }
    }
    
    func test_delete() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project, completion: nil)
        let project2 = Project(title: "삭제", description: "삭제 내용", date: Date())
        sut.create(project2, completion: nil)
        sut.create(project, completion: nil)
        
        // when
        sut.delete(project2) { item in
            
            // then
            XCTAssertNotNil(item)
            XCTAssertTrue(item?.title == "삭제")
        }
        XCTAssertTrue(sut.fetch().count == 2)
    }
    
    func test_delete_failed() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project, completion: nil)
        let project2 = Project(title: "삭제", description: "삭제 내용", date: Date())
        sut.create(project2, completion: nil)
        let project3 = Project(title: "실패", description: "실패 내용", date: Date())
        // when
        sut.delete(project3) { item in
            
            // then
            XCTAssertNil(item)
        }
        XCTAssertTrue(sut.fetch().count == 2)
    }
}
