import UIKit
import RxSwift

final class ProjectListViewModel: NSObject, ViewModelDescribing {
    final class Input {
        let selectCellObservable: Observable<(ProjectState, IndexPath)>
        let changeStateObservable: Observable<(ProjectState, ProjectState, IndexPath)>
        let deleteObservable: Observable<(ProjectState, IndexPath)>
        
        init(selectCellObservable: Observable<(ProjectState, IndexPath)>, changeStateObservable: Observable<(ProjectState, ProjectState, IndexPath)>, deleteObservable: Observable<(ProjectState, IndexPath)>) {
            self.selectCellObservable = selectCellObservable
            self.changeStateObservable = changeStateObservable
            self.deleteObservable = deleteObservable
        }
    }
    
    final class Output {
        let reloadObservable: Observable<Void>
        let showsEditViewControllerObservable: Observable<EditProjectDetailViewModel>
        
        init(reloadObservable: Observable<Void>, showsEditViewControllerObservable: Observable<EditProjectDetailViewModel>) {
            self.reloadObservable = reloadObservable
            self.showsEditViewControllerObservable = showsEditViewControllerObservable
        }   
    }
    
    private let reloadObservable: PublishSubject<Void> = PublishSubject<Void>()
    private let showsEditViewControllerObservable: PublishSubject<EditProjectDetailViewModel> = PublishSubject<EditProjectDetailViewModel>()
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        input
            .selectCellObservable
            .subscribe(onNext: { [weak self] (state, indexPath) in
                guard let selectedProject = self?.retrieveSelectedData(indexPath: indexPath, state: state) else {
                    return
                }
                let viewModel = EditProjectDetailViewModel(currentProject: selectedProject)
                self?.showsEditViewControllerObservable.onNext(viewModel)
            }).disposed(by: disposeBag)
        
        input
            .changeStateObservable
            .subscribe(onNext: { [weak self] (oldState, newState, indexPath) in
                self?.changeState(from: oldState, to: newState, indexPath: indexPath)
                self?.reloadObservable.onNext(())
            }).disposed(by: disposeBag)

        input
            .deleteObservable
            .subscribe(onNext: { [weak self] (state, indexPath) in
                self?.delete(indexPath: indexPath, state: state)
                self?.reloadObservable.onNext(())
            })
        
        let output = Output(
            reloadObservable: self.reloadObservable.asObservable(),
            showsEditViewControllerObservable: self.showsEditViewControllerObservable.asObservable()
        )
        
        return output
    }
    
    let useCase: ProjectUseCaseProtocol
    
    
    init(useCase: ProjectUseCaseProtocol) {
        self.useCase = useCase
    }
    
    private var projects: [Project] = []
    
    private var todoProjects: [Project] {
        projects.filter { $0.state == .todo }
    }
    
    private var doingProjects: [Project] {
        projects.filter { $0.state == .doing }
    }
    
    private var doneProjects: [Project] {
        projects.filter { $0.state == .done }
    }
    
    private func retrieveSelectedData(indexPath: IndexPath, state: ProjectState) -> Project? {
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
        return AddProjectDetailViewModel()
    }
}

extension ProjectListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = (tableView as? ProjectListTableView)?.state else {
            return .zero
        }
    
        switch state {
        case .todo:
            return todoProjects.count
        case .doing:
            return doingProjects.count
        case .done:
            return doneProjects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let state = ((tableView as? ProjectListTableView)?.state),
              let project = retrieveSelectedData(indexPath: indexPath, state: state),
              let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withClass: ProjectListTableViewCell.self)
        if project.date < yesterday {
            cell.populateDataWithDate(title: project.title, body: project.body, date: project.date)
        } else {
            cell.populateData(title: project.title, body: project.body, date: project.date)
        }

        return cell
    }
}
