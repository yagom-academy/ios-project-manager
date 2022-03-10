import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var bodyTextView: UITextView!

    var updateItem: TaskEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
