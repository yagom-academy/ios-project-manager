import UIKit
import Firebase

class MainViewController: UIViewController {
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    let memoryDataManager = MemoryDataManager()
    var test1: Work {
        let test = Work()
        test.title = "a"
        test.body = "a"
        test.date = Date()
        
        return test
    }
    var test2: Work {
        let test = Work()
        test.title = "b"
        test.body = """
                    sdlf
                    dslfkjas
                    dlfkajsd
                    """
        test.date = Date()
        
        return test
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        todoTableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        doingTableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        doneTableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        todoTableView.separatorColor = .clear
        todoTableView.backgroundColor = .systemGray5
        todoTableView.rowHeight = UITableView.automaticDimension
        todoTableView.estimatedRowHeight = 50
        memoryDataManager.create(test1)
        memoryDataManager.create(test2)
        todoTableView.dataSource = self
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryDataManager.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = memoryDataManager.todoList[indexPath.row].title
        cell.bodyLabel.text = memoryDataManager.todoList[indexPath.row].body
        cell.dateLabel.text = memoryDataManager.todoList[indexPath.row].convertedDate
        
        return cell
    }
}
