import UIKit

class ToDoDataSourceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(ProjectListCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        cell.setupLabelText(title: "프로젝트", preview: "1번: 앨리\n2번: 아샌\n2-1번: 찰리어쩔티비저쩔티비크크루삥뽕저쩔냉장고", date: "2022.03.04(Fri)")
        return cell
    }
}
