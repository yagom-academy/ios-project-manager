import Foundation

class ProjectRepository {
    weak var delegate: ProjectRepositoryDelegate?
    private var selectedProject: Project?
    private var projects: [Project] = [] {
        didSet {
            delegate?.didChangeProject()
        }
    }
    var todoProjects: [Project] {
        projects.filter { $0.state == .todo }
    }
    var doingProjects: [Project] {
        projects.filter { $0.state == .doing }
    }
    var doneProjects: [Project] {
        projects.filter { $0.state == .done }
    }
    
    func addProject(projectInput: ProjectInput) {
        let newProject = Project(title: projectInput.title, body: projectInput.body, date: projectInput.date)
        projects.append(newProject)
    }
    
    func editProject(with projectInput: ProjectInput) {
        guard let selectedProject = selectedProject,
              let index = projects.firstIndex(where: { $0 == selectedProject }) else { return }
        projects[index].title = projectInput.title
        projects[index].body = projectInput.body
        projects[index].date = projectInput.date
    }
    
    func deleteProject(_ project: Project) {
        guard let index = projects.firstIndex(where: { $0 == project }) else { return }
        projects.remove(at: index)
    }
    
    func changeState(of project: Project?, to state: ProjectState) {
        guard let index = projects.firstIndex(where: { $0 == project }) else { return }
        switch state {
        case .todo:
            projects[index].state = .todo
        case .doing:
            projects[index].state = .doing
        case .done:
            projects[index].state = .done
        }
    }
    
    func setSelectedProject(with project: Project) {
        selectedProject = project
    }
}
