import UIKit
import RxSwift

final class ProjectListViewModel: ViewModelType {
    struct Input {

    }
    
    struct Output {
        let todoProjects: Observable<[Project]>
        let doingProjects: Observable<[Project]>
        let doneProjects: Observable<[Project]>
    }
    
    func transform(input: Input) -> Output {
        let todoProjects = useCase.bindProjects()
            .map { $0.filter { $0.state == .todo }}
        
        let doingProjects = useCase.bindProjects()
            .map { $0.filter { $0.state == .doing }}
        
        let doneProjects = useCase.bindProjects()
            .map { $0.filter { $0.state == .done }}
        
        return Output(todoProjects: todoProjects,
                      doingProjects: doingProjects,
                      doneProjects: doneProjects)
    }
    
    let useCase: ProjectUseCaseProtocol
    
    init(useCase: ProjectUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func retrieveSelectedData(indexPath: IndexPath, state: ProjectState) -> Project? {
        return nil
    }
    
    func didSelectRow(indexPath: IndexPath, state: ProjectState) {
    }
    
    func append(_ project: Project) {
        useCase.append(project)
    }
    
    func update(_ project: Project, state: ProjectState?) {
        useCase.update(project, to: state)
    }
    
    func delete(indexPath: IndexPath, state: ProjectState) {
    }
    
    func changeState(from oldState: ProjectState, to newState: ProjectState, indexPath: IndexPath) {
    }
    
    func createEditDetailViewModel(indexPath: IndexPath, state: ProjectState) -> EditProjectDetailViewModel {
        let project = Project(id: UUID(), state: .todo, title: "", body: "", date: Date())
        return EditProjectDetailViewModel(currentProject: project)
    }
    
    func createAddDetailViewModel() -> AddProjectDetailViewModel {
        return AddProjectDetailViewModel(useCase: useCase)
    }
}
