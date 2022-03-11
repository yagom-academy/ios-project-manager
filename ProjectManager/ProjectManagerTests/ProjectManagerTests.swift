import XCTest
@testable import ProjectManager

class ProjectManagerTests: XCTestCase {
    var repo: MockProjectRepository!
    var useCase: ProjectUseCase!
    let id = [UUID(), UUID(), UUID(), UUID()]

    override func setUp() {
        let projects = [id[0]: Project(id: id[0], state: .todo, title: "할일이다", body: "할일할일할일ㅋㅋㅋㅋㅋㅋㅋㅋ", date: Date()),
                        id[1]: Project(id: id[1], state: .doing, title: "할일중이다", body: "하는중ㅋㅋㅋㅋㅋㅋㅋ", date: Date()),
                        id[2]: Project(id: id[2], state: .todo, title: "끝난일이다", body: "끝남ㅋㅋㅋㅋㅋㅋㅋㅋ", date: Date()),
                        id[3]: Project(id: id[3], state: .todo, title: "두번째할일ㄹ", body: "할ㄴㅁ일할일할ㄴㅁ일ㅋㅁㅋㅋㅋㅋㅋㅋㅋ", date: Date())]

        repo = MockProjectRepository(projects: projects)
        useCase = ProjectUseCase(repository: repo)
    }

    override func tearDownWithError() throws {
        repo = nil
        useCase = nil
    }
    
    func test_id가_같은_프로젝트가_정상적으로_수정되는지() {
        let newProject = Project(id: id[0], state: .doing, title: "이제 하는 중이다.", body: "말걸지마라", date: Date())
        useCase.update(with: newProject)
        
        XCTAssertEqual(newProject.body, repo.projects[id[0]]?.body)
    }
}
