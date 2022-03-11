import UIKit

protocol ProjectViewModelProtocol: UITableViewDataSource {
    var onCellSelected: ((Int, Project) -> Void)? { get set }
    var onUpdated: (() -> Void)? { get set }
//    var onCreated?:
    var todoProjects: [Project] { get }
    var doingProjects: [Project] { get }
    var doneProjects: [Project] { get }
    var tableViews: [ProjectListTableView]? { get set }
    
    func didSelectRow(index: IndexPath, tableView: UITableView)
    func fetchAll()
    func create(with project: Project)
    func update(with project: Project)
    func delete(index: IndexPath, tableView: UITableView)
}

class ProjectViewModel: NSObject, ProjectViewModelProtocol {
    let useCase: ProjectUseCaseProtocol

    var onCellSelected: ((Int, Project) -> Void)?
    var onUpdated: (() -> Void)?
    
    var projects: [Project] = []
    var tableViews: [ProjectListTableView]?
    
    init(useCase: ProjectUseCaseProtocol) {
        self.useCase = useCase
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
    
    func retrieveSelectedData(index: IndexPath, tableView: UITableView) -> Project? {
        var selectedProject: Project?
        switch tableView {
        case tableViews?[0]:
            selectedProject = todoProjects[index.row]
        case tableViews?[1]:
            selectedProject = doingProjects[index.row]
        case tableViews?[2]:
            selectedProject = doneProjects[index.row]
        default:
            break
        }
        
        return selectedProject
    }
    
    func didSelectRow(index: IndexPath, tableView: UITableView) {
        guard let selectedProject = retrieveSelectedData(index: index, tableView: tableView) else {
            return
        }
        onCellSelected?(index.row, selectedProject)
    }
    
    func fetchAll() {
        projects = useCase.fetchAll()
    }
    
    func create(with project: Project) {
        useCase.create(with: project)
        fetchAll()
        onUpdated?()
    }
    
    func update(with project: Project) {
        useCase.update(with: project)
        fetchAll()
        onUpdated?()
    }
    
    func delete(index: IndexPath, tableView: UITableView) {
        guard let project = retrieveSelectedData(index: index, tableView: tableView) else {
            return
        }
        useCase.delete(with: project)
        fetchAll()
        onUpdated?()
    }
}

extension ProjectViewModel {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int = .zero
        switch tableView {
        case tableViews?[0]:
            numberOfRows = todoProjects.count
        case tableViews?[1]:
            numberOfRows = doingProjects.count
        case tableViews?[2]:
            numberOfRows = doneProjects.count
        default:
            break
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ProjectListTableViewCell.self)
        var projects: [Project] = []
        
        switch tableView {
        case tableViews?[0]:
            projects = todoProjects
        case tableViews?[1]:
            projects = doingProjects
        case tableViews?[2]:
            projects = doneProjects
        default:
            break
        }
        
        let project = projects[indexPath.row]

        cell.populateData(title: project.title, body: project.body, date: project.date)
        return cell
    }
}
