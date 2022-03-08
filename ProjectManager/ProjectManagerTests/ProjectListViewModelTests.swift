import XCTest
import RxBlocking

class ProjectListViewModelTests: XCTestCase {

    var sut: ProjectListViewModel?
    
    override func setUpWithError() throws {
        sut = ProjectListViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_프로젝트1개를_create하면_총데이터갯수는_1개이다() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        
        // when
        sut?.add(newItem)
        
        // then
        XCTAssertTrue(sut?.projects.count == 1)
        XCTAssertTrue(sut?.projects.first?.id == newItem.id)
    }
    
    func test_프로젝트1개를_update하면_정상적으로_수정된다() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        sut?.add(newItem)
        let editItem = Project(id: newItem.id, title: "수정", description: "내용", date: Date(), status: .todo)
        
        // when
        sut?.update(editItem, indexPath: IndexPath(row: .zero, section: .zero))
        
        // then
        XCTAssertTrue(sut?.projects[0].title == "수정")
        XCTAssertTrue(sut?.projects[0].id == editItem.id)
    }
    
    func test_프로젝트1개를_잘못된ID로_update하면_실패한다() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        sut?.add(newItem)
        let editItem = Project(id: UUID(), title: "수정", description: "내용", date: Date(), status: .todo)
        
        // when
        sut?.update(editItem, indexPath: IndexPath(row: .zero, section: .zero))
        // then
        XCTAssertFalse(sut?.projects[0].title == "수정")
    }
    
    func test_프로젝트1개를추가하고_삭제하면_리스트는비어있다() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        sut?.add(newItem)
        
        // when
        sut?.delete(IndexPath(row: .zero, section: .zero))
        
        // then
        XCTAssertTrue(sut!.projects.isEmpty)
    }
    
    func test_잘못된프로젝트를_삭제하면_실패한다() {
        // given
        let newItem = Project(title: "제목", description: "내용", date: Date())
        sut?.add(newItem)
        
        // when
        sut?.delete(IndexPath(row: 1, section: .zero))
        
        // then
        XCTAssertTrue(sut?.projects.count == 1)
    }

}
