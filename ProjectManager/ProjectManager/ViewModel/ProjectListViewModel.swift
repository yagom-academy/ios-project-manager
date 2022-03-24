import UIKit

final class ProjectListViewModel: ViewModelType {
    final class Input {
//        let doneButton
    }
    
    final class Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    let useCase: ProjectUseCaseProtocol
    
    var onCellSelected: ((IndexPath, Project) -> Void)?
    var onUpdated: (() -> Void)?
    
    init(useCase: ProjectUseCaseProtocol) {
        self.useCase = useCase
    }
    
    private var projects: [Project] = [] {
        didSet {
            onUpdated?()
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
    
    func retrieveSelectedData(indexPath: IndexPath, state: ProjectState) -> Project? {
        var selectedProject: Project?
        switch state {
        case .todo:
            selectedProject = todoProjects[indexPath.row]
        case .doing:
            selectedProject = doingProjects[indexPath.row]
        case .done:
            selectedProject = doneProjects[indexPath.row]
        }
        
        return selectedProject
    }
    
    func didSelectRow(indexPath: IndexPath, state: ProjectState) {
        guard let selectedProject = retrieveSelectedData(indexPath: indexPath, state: state) else {
            return
        }
        onCellSelected?(indexPath, selectedProject)
    }
    
    func numberOfProjects(state: ProjectState) -> Int {
        switch state {
        case .todo:
            return todoProjects.count
        case .doing:
            return doingProjects.count
        case .done:
            return doneProjects.count
        }
    }
    
    func fetchAll() {
        projects = useCase.fetchAll()
    }
    
    func append(_ project: Project) {
        useCase.append(project)
        fetchAll()
    }
    
    func update(_ project: Project, state: ProjectState?) {
        useCase.update(project, to: state)
        fetchAll()
    }
    
    func delete(indexPath: IndexPath, state: ProjectState) {
        guard let project = retrieveSelectedData(indexPath: indexPath, state: state) else {
            return
        }
        useCase.delete(project)
        fetchAll()
    }
    
    func changeState(from oldState: ProjectState, to newState: ProjectState, indexPath: IndexPath) {
        guard let project = retrieveSelectedData(indexPath: indexPath, state: oldState) else {
            return
        }
        self.update(project, state: newState)
    }
    
    func createEditDetailViewModel(indexPath: IndexPath, state: ProjectState) -> EditProjectDetailViewModel {
        let project = retrieveSelectedData(indexPath: indexPath, state: state) ?? Project(id: UUID(), state: .todo, title: "", body: "", date: Date())
        return EditProjectDetailViewModel(currentProject: project)
    }
    
    func createAddDetailViewModel() -> AddProjectDetailViewModel {
        return AddProjectDetailViewModel(useCase: useCase)
    }
}
