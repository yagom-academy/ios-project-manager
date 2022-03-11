import XCTest
@testable import ProjectManager

class ProjectManagerTests: XCTestCase {
    var mockRepository: MockProjectRepository!
    var useCase: ProjectUseCase!
    let id = [UUID(), UUID(), UUID(), UUID()]

    override func setUp() {
        let projects = [id[0]: Project(id: id[0], state: .todo, title: "할일이다", body: "할일", date: Date(timeIntervalSince1970: 1000))]
        mockRepository = MockProjectRepository(projects: projects)
        useCase = ProjectUseCase(repository: mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
    }
    
    func test_새로운_프로젝트가_정상적으로_생성되는지() {
        let project = Project(id: UUID(), state: .todo, title: "새로운 할일", body: "열심히하세요", date: Date())

        useCase.create(with: project)
        
        XCTAssertEqual("새로운 할일", mockRepository.projects[project.id]?.title)
    }
    
    func test_repository에서_모든_프로젝트를_정상적으로_가져오는지() {
        let projects = useCase.fetchAll()
        
        XCTAssertEqual(Project(id: id[0], state: .todo, title: "할일이다", body: "할일", date: Date(timeIntervalSince1970: 1000)), projects[0])
    }
    
    func test_id가_같은_프로젝트가_정상적으로_수정되는지() {
        let newProject = Project(id: id[0], state: .doing, title: "이제 하는 중이다.", body: "말걸지마라", date: Date())
        
        useCase.update(with: newProject)
        
        XCTAssertEqual(newProject.body, mockRepository.projects[id[0]]?.body)
    }
    
    func test_id가_같은_프로젝트가_정상적으로_삭제되는지() {
        let projectToDelete = Project(id: id[0], state: .doing, title: "이제 하는 중이다.", body: "말걸지마라", date: Date())
        
        useCase.delete(with: projectToDelete)
        
        XCTAssertEqual(mockRepository.projects, [:])
    }
}
