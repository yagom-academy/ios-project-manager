import UIKit

class ProjectListDataSource: NSObject, UITableViewDataSource {
    private var tableViews: [ProjectListTableView]
    
    init(tableView: [ProjectListTableView]) {
        self.tableViews = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int = .zero
        switch tableView {
        case tableViews[0]:
            numberOfRows = 3
        case tableViews[1]:
            numberOfRows = 5
        case tableViews[2]:
            numberOfRows = 15
        default:
            break
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ProjectTableViewCell.self)
        
        return cell
    }
}
