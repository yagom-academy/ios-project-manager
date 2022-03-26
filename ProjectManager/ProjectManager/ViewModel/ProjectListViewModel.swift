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
    
    func append(_ project: Project) {
        useCase.append(project)
    }
    
    func update(_ project: Project, state: ProjectState?) {
        useCase.update(project, to: state)
    }
    
    func delete(project: Project) {
        useCase.delete(project)
    }
    
    func changeState(from oldState: ProjectState, to newState: ProjectState, indexPath: IndexPath) {
    }
    
    func createEditDetailViewModel(with selectedProject: Project) -> EditProjectDetailViewModel {
        return EditProjectDetailViewModel(usecase: useCase, currentProject: selectedProject)
    }
    
    func createAddDetailViewModel() -> AddProjectDetailViewModel {
        return AddProjectDetailViewModel(useCase: useCase)
    }
}
