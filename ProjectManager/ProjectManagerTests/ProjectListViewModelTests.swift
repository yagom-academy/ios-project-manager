import XCTest

class ProjectListViewModelTests: XCTestCase {

    var sut = ProjectListViewModel()
    
    func test_crate() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        
        // when
        sut.add(newItem)
        
        // then
        XCTAssertTrue(sut.projects.count == 1)
    }
    
    func test_update() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        sut.add(newItem)
        let editItem = Project(id: newItem.id, title: "수정", description: "내용", date: Date(), status: .todo)
        
        // when
        sut.update(editItem, indexPath: IndexPath(row: .zero, section: .zero))
        
        // then
        XCTAssertTrue(sut.projects[0].title == "수정")
    }
    
    func test_update_failed() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        sut.add(newItem)
        let editItem = Project(id: UUID(), title: "수정", description: "내용", date: Date(), status: .todo)
        
        // when
        sut.update(editItem, indexPath: IndexPath(row: .zero, section: .zero))
        
        // then
        XCTAssertFalse(sut.projects[0].title == "수정")
    }
    
    func test_delete() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        sut.add(newItem)
        
        // when
        sut.delete(IndexPath(row: .zero, section: .zero)) { item in
            
            // then
            XCTAssertNotNil(item)
            XCTAssertTrue(item?.title == "제목")
        }
        XCTAssertTrue(sut.projects.isEmpty)
    }
    
    func test_delete_failed() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        sut.add(newItem)
        
        // when
        sut.delete(IndexPath(row: 1, section: .zero)) { item in
            
            // then
            XCTAssertNil(item)
        }
        XCTAssertTrue(sut.projects.count == 1)
    }

}
