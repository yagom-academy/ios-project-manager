import UIKit

class TaskTablesViewController: UICollectionViewController {
    var viewModel: TaskViewModel?
    
    init?(coder: NSCoder, viewModel: TaskViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
