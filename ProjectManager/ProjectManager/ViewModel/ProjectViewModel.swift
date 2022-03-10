import UIKit

class ProjectViewModel: NSObject {
    var onCellSelected: ((Int, Project) -> Void)?
//    var onUpdated: (() -> Void)?
    
    private var projects = [Project(id: UUID(), state: .todo, title: "todo", body: "todobody", date: Date()),
                            Project(id: UUID(), state: .doing, title: "doing", body: "doingbody", date: Date()),
                            Project(id: UUID(), state: .done, title: "done", body: "donebody", date: Date())]
    
    private var tableViews: [ProjectListTableView]
    
    init(tableView: [ProjectListTableView]) {
        self.tableViews = tableView
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
    
    func update(index: Int, title: String, body: String, date: Date, project: Project) {
        //        domain.update(index: index, title: title, body: body, date: date, project: project)
    }
    
    func didSelectRow(index: IndexPath, tableView: UITableView) {
        var selectedProject: Project?
        switch tableView {
        case tableViews[0]:
            selectedProject = todoProjects[index.row]
        case tableViews[1]:
            selectedProject = doingProjects[index.row]
        case tableViews[2]:
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

extension ProjectViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int = .zero
        switch tableView {
        case tableViews[0]:
            numberOfRows = todoProjects.count
        case tableViews[1]:
            numberOfRows = doingProjects.count
        case tableViews[2]:
            numberOfRows = doneProjects.count
        default:
            break
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ProjectListTableViewCell.self)
        
        return cell
    }
}
