import Foundation

protocol ProjectUseCaseProtocol {
    
}

class ProjectUseCase {
    let projectRepository: ProjectRepositoryProtocol
    
    init(repository: ProjectRepositoryProtocol) {
        self.projectRepository = repository
    }
//
//    func fetch(index, state) -> Project {
//        projectRepository.fetchAll()
//        dd = fetchdata.filter( $0.state == state)
//        return dd[index]
//    }
//
//    func update(index: Int, title: String, body: String, date: Date, project: Project) {
//        let project = fetch(index, project.state)
//
//        let project11 = Project(id: project.id, state: project.state, title: title, body: body, date: date)
//
//        repo.update(project11)
//    }
}
