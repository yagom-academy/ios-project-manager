import UIKit

protocol ProjectViewModelProtocol: UITableViewDataSource {
    var onCellSelected: ((Int, Project) -> Void)? { get set }
    var onUpdated: (() -> Void)? { get set }
    
    var todoProjects: [Project] { get }
    var doingProjects: [Project] { get }
    var doneProjects: [Project] { get }
    var tableViews: [ProjectListTableView]? { get set }
    
    func didSelectRow(index: IndexPath, tableView: UITableView)
    func update(with project: Project)
}

class ProjectViewModel: NSObject, ProjectViewModelProtocol {
    let useCase: ProjectUseCaseProtocol

    var onCellSelected: ((Int, Project) -> Void)?
    var onUpdated: (() -> Void)?
    
    static var projects = [Project(id: UUID(), state: .todo, title: "투두", body: "돈내놔", date: Date()),
                            Project(id: UUID(), state: .doing, title: "두잉", body: "ㅇㅇㅂㅇㅂㅉㅇㅂㅇ", date: Date()),
                            Project(id: UUID(), state: .done, title: "돈", body: "ㅇ애애ㅐ애애애애애앵ㅂㅈㅇㅂㅇㅂㅇ빙빙지이이잉이이ㅣ이잉이이이ㅣㅣ이ㅇㅈㅂ앱재앱ㅇ앵배아아배아ㅐ이이이이이이이", date: Date()),
                            Project(id: UUID(), state: .done, title: "돈돈돈돋논돋논돈도돈도돋도도도도도도도ㅗ도도", body: "애ㅇㅂㅈㅇㅂㅇㅂㅇ앶뱆아ㅐㅂㅈ애앵배아아배아ㅐ이이이이이이이", date: Date())] // 테스트용 static
    
    var tableViews: [ProjectListTableView]?
    
    init(useCase: ProjectUseCaseProtocol) {
        self.useCase = useCase
    }
    
    var todoProjects: [Project] {
        ProjectViewModel.projects.filter { $0.state == .todo }
    }
    
    var doingProjects: [Project] {
        ProjectViewModel.projects.filter { $0.state == .doing }
    }
    
    var doneProjects: [Project] {
        ProjectViewModel.projects.filter { $0.state == .done }
    }
    
    func update(with project: Project) {
        useCase.update(with: project)
        onUpdated?()
    }
    
    func didSelectRow(index: IndexPath, tableView: UITableView) {
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
        
        guard let selectedProject = selectedProject else {
            return
        }
        onCellSelected?(index.row, selectedProject)
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
