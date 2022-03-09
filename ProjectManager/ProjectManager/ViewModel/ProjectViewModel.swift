import UIKit

class ProjectViewModel: NSObject {
    var onSelected: ((Project) -> Void)?
    private var projects = [Project(state: .todo, title: "todo", body: "todobody", date: Date()),
                            Project(state: .doing, title: "doing", body: "doingbody", date: Date()),
                            Project(state: .done, title: "done", body: "donebody", date: Date())]
    
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
    
    func didSelectRow(index: IndexPath, state: Project.State) {
        let selectedProject: Project?
        switch state {
        case .todo:
            selectedProject = todoProjects[index.row]
        case .doing:
            selectedProject = doingProjects[index.row]
        case .done:
            selectedProject = doneProjects[index.row]
        }
        
        guard let selectedProject = selectedProject else {
            return
        }
        onSelected?(selectedProject)
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
