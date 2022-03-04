import UIKit

class ToDoDataSourceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(ProjectListCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        
        return cell
    }
}
