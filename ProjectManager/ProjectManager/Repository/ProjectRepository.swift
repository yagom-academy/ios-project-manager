import Foundation
import RxSwift
import RxRelay

protocol ProjectRepositoryProtocol {
    func bindProjects() -> BehaviorRelay<[UUID: Project]>
    func append(_ project: Project)
    func update(_ project: Project)
    func delete(_ project: Project)
}

final class ProjectRepository: ProjectRepositoryProtocol {
    let id = [UUID(), UUID(), UUID(), UUID()] // 테스트용
    
    private lazy var projects = BehaviorRelay<[UUID: Project]>(value: [id[0]: Project(id: id[0], state: .todo, title: "투두", body: "앞으로 해야할 일", date: Date(timeIntervalSince1970: 1000)),
                                                                 id[1]: Project(id: id[1], state: .doing, title: "두잉", body: "아직도 끝나지 않은 일들", date: Date(timeIntervalSince1970: 1000)),
                                                                 id[2]: Project(id: id[2], state: .done, title: "돈", body: "여기에는 기한이 지난 할일의 내용이 나오는 곳입니다.", date: Date(timeIntervalSince1970: 1000)),
                                                                 id[3]:Project(id: id[3], state: .done, title: "이미 끝난 일", body: "오늘 할 일을 내일로 미루지 말자.", date: Date(timeIntervalSince1970: 1000))])
    
    func bindProjects() -> BehaviorRelay<[UUID: Project]> {
        return projects
    }
    
    func append(_ project: Project) {
        var currentProjects = projects.value
        currentProjects[project.id] = project
        projects.accept(currentProjects)
    }
    
    func update(_ project: Project) {
        var currentProjects = projects.value
        currentProjects.updateValue(project, forKey: project.id)
        projects.accept(currentProjects)
    }
    
    func delete(_ project: Project) {
        var currentProjects = projects.value
        currentProjects.removeValue(forKey: project.id)
        projects.accept(currentProjects)
    }
}
