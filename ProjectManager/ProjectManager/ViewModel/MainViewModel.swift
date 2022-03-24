import Foundation
import RxSwift

protocol ViewModelDescribing {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

class MainViewModel: ViewModelDescribing {
    final class Input {
        let moveToToDoObserver: Observable<CellInformation>
        let moveToDoingObserver: Observable<CellInformation>
        let moveToDoneObserver: Observable<CellInformation>
        let selectObserver: Observable<Project>
        let deleteObserver: Observable<Project>
        
        init(moveToToDoObserver: Observable<CellInformation>, moveToDoingObserver: Observable<CellInformation>, moveToDoneObserver: Observable<CellInformation>, selectObserver: Observable<Project>, deleteObserver: Observable<Project>) {
            self.moveToToDoObserver = moveToToDoObserver
            self.moveToDoingObserver = moveToDoingObserver
            self.moveToDoneObserver = moveToDoneObserver
            self.selectObserver = selectObserver
            self.deleteObserver = deleteObserver
        }
    }
    
    final class Output {
        let reloadObserver: Observable<Void>
        
        init(reloadObserver: Observable<Void>) {
            self.reloadObserver = reloadObserver
        }
    }
    
    private let repository = ProjectRepository()
    private let reloadObserver: PublishSubject<Void> = .init()
    private let disposeBag: DisposeBag = .init()
    
    private var selectedProject: Project?
    private var projects: [Project] = []
    var todoProjects: [Project] {
        repository.todoProjects
    }
    var doingProjects: [Project] {
        repository.doingProjects
    }
    var doneProjects: [Project] {
        repository.doneProjects
    }

    init() {
        repository.delegate = self
    }
    
    func transform(_ input: Input) -> Output {
        input
            .moveToToDoObserver
            .subscribe(onNext: { [weak self] cellInformation in
                let project = self?.findProjectNeedChange(from: cellInformation.state, with: cellInformation.indexPath)
                self?.changeState(of: project, to: .todo)
                self?.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .moveToDoingObserver
            .subscribe(onNext: { [weak self] cellInformation in
                let project = self?.findProjectNeedChange(from: cellInformation.state, with: cellInformation.indexPath)
                self?.changeState(of: project, to: .doing)
                self?.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .moveToDoneObserver
            .subscribe(onNext: { [weak self] cellInformation in
                let project = self?.findProjectNeedChange(from: cellInformation.state, with: cellInformation.indexPath)
                self?.changeState(of: project, to: .done)
                self?.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .selectObserver
            .subscribe(onNext: { [weak self] project in
                self?.repository.setSelectedProject(with: project)
            })
            .disposed(by: disposeBag)
        
        input
            .deleteObserver
            .subscribe(onNext: { [weak self] project in
                self?.deleteProject(project)
            })
            .disposed(by: disposeBag)
        
        let output = Output(reloadObserver: self.reloadObserver.asObservable())
        
        return output
    }
    
    func makeAddProjectViewModel() -> AddProjectViewModel {
        return AddProjectViewModel(repository: repository)
    }
    
    func makeEditProjectViewModel() -> EditProjectViewModel {
        return EditProjectViewModel(repository: repository)
    }
    
    private func changeState(of project: Project?, to state: ProjectState) {
        repository.changeState(of: project, to: state)
    }
    
    private func findProjectNeedChange(from state: ProjectState, with indexPath: IndexPath) -> Project {
        switch state {
        case .todo:
            return todoProjects[indexPath.row]
        case .doing:
            return doingProjects[indexPath.row]
        case .done:
            return doneProjects[indexPath.row]
        }
    }
    
    private func deleteProject(_ project: Project) {
        repository.deleteProject(project)
    }
}

extension MainViewModel: ProjectRepositoryDelegate {
    func didChangeProject() {
        reloadObserver.onNext(())
    }
}

