import Foundation
import RxSwift

protocol ViewModelDescribing {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

class ProjectViewModel: ViewModelDescribing {
    final class Input {
        let moveToToDoObserver: Observable<Project>
        let moveToDoingObserver: Observable<Project>
        let moveToDoneObserver: Observable<Project>
        
        init(moveToToDoObserver: Observable<Project>, moveToDoingObserver: Observable<Project>, moveToDoneObserver: Observable<Project>) {
            self.moveToToDoObserver = moveToToDoObserver
            self.moveToDoingObserver = moveToDoingObserver
            self.moveToDoneObserver = moveToDoneObserver
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
    
    private var projects: [Project] = [
        Project(title: "1번", body: "프로젝트 1번 입니다", date: Date().timeIntervalSince1970),
        Project(title: "2번", body: "프로젝트 2번 입니다", date: Date().timeIntervalSince1970),
        Project(title: "3번", body: "프로젝트 3번 입니다", date: Date().timeIntervalSince1970),
        Project(title: "4번", body: "프로젝트 4번 입니다", date: Date().timeIntervalSince1970)
    ]
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
            .subscribe(onNext: { project in
                self.changeState(of: project, to: .todo)
                self.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .moveToDoingObserver
            .subscribe(onNext: { project in
                self.changeState(of: project, to: .doing)
                self.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        input
            .moveToDoneObserver
            .subscribe(onNext: { project in
                self.changeState(of: project, to: .done)
                self.reloadObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        let output = Output(reloadObserver: self.reloadObserver.asObservable())
        
        return output
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
}
