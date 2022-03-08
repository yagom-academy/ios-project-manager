import UIKit

class ProjectViewModel: NSObject, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int = .zero
        switch tableView {
        case tableViews[0]:
            numberOfRows = 1
        case tableViews[1]:
            numberOfRows = 1
        case tableViews[2]:
            numberOfRows = 1
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
