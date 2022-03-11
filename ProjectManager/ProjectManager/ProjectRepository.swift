import Foundation

protocol ProjectRepositoryProtocol {
//    var projects: [UUID: Project] { get set }
    func update(with project: Project)
    func create(with project: Project)
    func fetchAll() -> [UUID: Project]
}

class ProjectRepository: ProjectRepositoryProtocol {
    let id = [UUID(), UUID(), UUID(), UUID()] // 테스트용
    
    private lazy var projects = [id[0]: Project(id: id[0], state: .todo, title: "투두", body: "돈내놔", date: Date()),
                             id[1]: Project(id: id[1], state: .doing, title: "두잉", body: "ㅇㅇㅂㅇㅂㅉㅇㅂㅇ", date: Date()),
                             id[2]: Project(id: id[2], state: .done, title: "돈", body: "ㅇ애애ㅐ애애애애애앵ㅂㅈㅇㅂㅇㅂㅇ빙빙지이이잉이이ㅣ이잉이이이ㅣㅣ이ㅇㅈㅂ앱재앱ㅇ앵배아아배아ㅐ이이이이이이이", date: Date()),
                             id[3]:Project(id: id[3], state: .done, title: "돈돈돈돋논돋논돈도돈도돋도도도도도도도ㅗ도도", body: "애ㅇㅂㅈㅇㅂㅇㅂㅇ앶뱆아ㅐㅂㅈ애앵배아아배아ㅐ이이이이이이이", date: Date())] // 테스트용
    
    func create(with project: Project) {
        projects[project.id] = project
    }
    
    func update(with project: Project) {
        projects.updateValue(project, forKey: project.id)
    }
    
    func fetchAll() -> [UUID: Project] {
        return projects
    }
}
