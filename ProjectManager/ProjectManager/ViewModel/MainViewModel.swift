import Foundation
import RxSwift

protocol ViewModelDescribing {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

class MainViewModel: ViewModelDescribing {
    final class Input {
        let moveToToDoObserver: Observable<Project>
        let moveToDoingObserver: Observable<Project>
        let moveToDoneObserver: Observable<Project>
        let selectObserver: Observable<Project>
        let deleteObserver: Observable<Project>
        
        init(moveToToDoObserver: Observable<Project>, moveToDoingObserver: Observable<Project>, moveToDoneObserver: Observable<Project>, selectObserver: Observable<Project>, deleteObserver: Observable<Project>) {
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
    
    private let reloadObserver: PublishSubject<Void> = .init()
    private let disposeBag: DisposeBag = .init()
    
    private var selectedProject: Project?
    private var projects: [Project] = []
    var todoProjects: [Project] {
        projects.filter { $0.state == .todo }
    }
    var doingProjects: [Project] {
        projects.filter { $0.state == .doing }
    }
    var doneProjects: [Project] {
        projects.filter { $0.state == .done }
    }

    func transform(_ input: Input) -> Output {
        input
            .moveToToDoObserver
            .subscribe(onNext: { [weak self] project in
                self?.changeState(of: project, to: .todo)
                self?.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .moveToDoingObserver
            .subscribe(onNext: { [weak self] project in
                self?.changeState(of: project, to: .doing)
                self?.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .moveToDoneObserver
            .subscribe(onNext: { [weak self] project in
                self?.changeState(of: project, to: .done)
                self?.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .selectObserver
            .subscribe(onNext: { [weak self] project in
                self?.selectedProject = project
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
    
    func addProject(title: String?, body: String?, date: TimeInterval) {
        let newProject = Project(title: title, body: body, date: date)
        projects.append(newProject)
        reloadObserver.onNext(())
    }
    
    func editProject(title: String?, body: String?, date: TimeInterval) {
        guard let selectedProject = selectedProject,
              let index = projects.firstIndex(where: { $0 == selectedProject }) else { return }
        projects[index].title = title
        projects[index].body = body
        projects[index].date = date
        reloadObserver.onNext(())
    }
    
    private func changeState(of project: Project, to state: ProjectState) {
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
    
    private func deleteProject(_ project: Project) {
        guard let index = projects.firstIndex(where: { $0 == project }) else { return }
        projects.remove(at: index)
        reloadObserver.onNext(())
    }
}
