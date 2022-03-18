import XCTest
import RxBlocking

class MemoryUseCaseTests: XCTestCase {

    var sut: ProjectListUseCase!
    
    override func setUpWithError() throws {
        sut = DefaultProjectListUseCase()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_프로젝트1개를_create하면_데이터의갯수가_1개이다() throws {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        
        // when
        let result = try sut.create(project).toBlocking(timeout: 1).toArray()
        let fetch = try sut.fetch().toBlocking(timeout: 1).first()
        
        // then
        XCTAssertTrue(fetch?.count == 1)
        XCTAssertTrue(fetch?.first?.id == result.first?.id)
    }
    
    func test_프로젝트3개를_create하면_데이터의갯수가_3개이다() throws {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        
        // when
        sut.create(project)
        sut.create(project)
        sut.create(project)
        let result = try sut.fetch().toBlocking(timeout: 1).first()?.count
        
        // then
        XCTAssertTrue(result == 3)
    }
    
    func test_프로젝트1개를_update하면_기존데이터가_수정되어있다() throws {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project)
        let newProject = Project(id: project.id, title: "수정", description: "수정 내용", date: Date(), status: .doing)
        
        // when
        let result = try? sut.update(newProject).toBlocking().first()
        let projectsCount = try? sut.fetch().toBlocking(timeout: 1).first()?.count
        
        // then
        XCTAssertTrue(result?.title == "수정")
        XCTAssertTrue(result?.id == project.id)
        XCTAssertTrue(projectsCount == 1)
    }
    
    func test_프로젝트1개를_잘못된ID로_update하면_실패한다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project)
        let newProject = Project(id: UUID(), title: "수정", description: "수정 내용", date: Date(), status: .doing)
        
        // when
        let reuslt = try? sut.update(newProject).toBlocking().first()
        
        // then
        XCTAssertNil(reuslt)
    }
    
    func test_프로젝트3개를추가하고_1개를삭제하면_총데이터갯수는_2개다() throws {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project)
        let project2 = Project(title: "삭제", description: "삭제 내용", date: Date())
        sut.create(project2)
        sut.create(project)
        
        // when
        let result = try sut.delete(project2).toBlocking().first()
        let projectsCount = try sut.fetch().toBlocking(timeout: 1).first()?.count
        
        // then
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.title == "삭제")
        XCTAssertTrue(projectsCount == 2)
    }
    
    func test_존재하지않는데이터를_삭제하면_실패한다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project)
        let project2 = Project(title: "삭제", description: "삭제 내용", date: Date())
        sut.create(project2)
        let project3 = Project(title: "실패", description: "실패 내용", date: Date())
        
        // when
        let result = try? sut.delete(project3).toBlocking().first()
        let projectsCount = try? sut.fetch().toBlocking(timeout: 1).first()?.count

        // then
        XCTAssertNil(result)
        XCTAssertTrue(projectsCount == 2)
    }
    
    func test_fetch를하면_정상적인_배열이반환된다() throws {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project)
        let project2 = Project(title: "삭제", description: "삭제 내용", date: Date())
        sut.create(project2)
        
        // when
        let result = try sut.fetch().toBlocking(timeout: 1).first()
        
        // then
        XCTAssertTrue(result?.count == 2)
    }
    
    func test_UUID로_특정한_프로젝트만_fetch해오기() throws {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project)
        let project2 = Project(title: "삭제", description: "삭제 내용", date: Date())
        sut.create(project2)
        
        // when
        let result = try sut.fetch(id: project2.id).toBlocking(timeout: 1).first()
        
        // then
        XCTAssertTrue(result?.id == project2.id)
    }
    
    func test_프로젝트의_상태를_done으로_바꾸기성공() throws {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        sut.create(project)
        
        // when
        sut.changedState(project, state: .done)
        let result = try sut.fetch(id: project.id).toBlocking(timeout: 1).first()
        
        // then
        XCTAssertTrue(result?.status == .done)
    }
    
    func test_존재하지않는_프로젝트의_상태를_변경하면_실패한다() {
        // given
        let project = Project(title: "제목", description: "상세 내용", date: Date())
        
        // when
        sut.changedState(project, state: .done)
        let result = try? sut.fetch(id: project.id).toBlocking(timeout: 1).first()
        
        // then
        XCTAssertTrue(result?.status == nil)
    }
    
    func test_1000자_미만일경우_false를_반환한다() {
        // giver
        let text = "1234567889"
        
        // when
        let result = sut!.isNotValidate(text)
        
        // then
        XCTAssertFalse(result)
    }
    
    func test_1000자_이상일경우_true를_반환한다() {
        // giver
        let text = "123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889123456788912345678891234567889"
        
        // when
        let result = sut!.isNotValidate(text)
        
        // then
        XCTAssertTrue(result)
    }
}
