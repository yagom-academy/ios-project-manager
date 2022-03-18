import UIKit

final class TaskDetailViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var bodyTextView: UITextView!

    var updateItem: TaskModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneButtonDidTap(_ sender: Any) {}
}
