import XCTest
import RxBlocking

class MemoryUseCaseTests: XCTestCase {

    var sut: MemoryUseCase?
    
    override func setUpWithError() throws {
        sut = MemoryUseCase()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_프로젝트1개를_create하면_데이터의갯수가_1개이다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        
        // when
        sut?.create(project)
        XCTAssertTrue(try! sut?.fetch().toBlocking(timeout: 1).first()?.count == 1)
    }
    
    func test_프로젝트3개를_create하면_데이터의갯수가_3개이다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        
        // when
        sut?.create(project)
        sut?.create(project)
        sut?.create(project)
        
        // then
        XCTAssertTrue(try! sut?.fetch().toBlocking(timeout: 1).first()?.count == 3)
    }
    
    func test_프로젝트1개를_update하면_기존데이터가_수정되어있다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut?.create(project)
        let newProject = Project(id: project.id, title: "수정", description: "수정 내용", date: Date(), status: .doing)
        
        // when
        let result = try? sut?.update(newProject).toBlocking().first()
        
        // then
        XCTAssertTrue(result?.title == "수정")
        XCTAssertTrue(result?.id == project.id)
        XCTAssertTrue(try! sut?.fetch().toBlocking(timeout: 1).first()?.count == 1)
    }
    
    func test_프로젝트1개를_잘못된ID로_update하면_실패한다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut?.create(project)
        let newProject = Project(id: UUID(), title: "수정", description: "수정 내용", date: Date(), status: .doing)
        
        // when
        let reuslt = try? sut?.update(newProject).toBlocking().first()
        
        // then
        XCTAssertNil(reuslt)
    }
    
    func test_프로젝트3개를추가하고_1개를삭제하면_총데이터갯수는_2개다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut?.create(project)
        let project2 = Project(title: "삭제", description: "삭제 내용", date: Date())
        sut?.create(project2)
        sut?.create(project)
        
        // when
        let result = try? sut?.delete(project2).toBlocking().first()
        
        // then
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.title == "삭제")
        XCTAssertTrue(try! sut?.fetch().toBlocking(timeout: 1).first()?.count == 2)
    }
    
    func test_존재하지않는데이터를_삭제하면_실패한다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut?.create(project)
        let project2 = Project(title: "삭제", description: "삭제 내용", date: Date())
        sut?.create(project2)
        let project3 = Project(title: "실패", description: "실패 내용", date: Date())
        
        // when
        let result = try? sut?.delete(project3).toBlocking().first()

        // then
        XCTAssertNil(result)
        XCTAssertTrue(try! sut?.fetch().toBlocking(timeout: 1).first()?.count == 2)
    }
}
