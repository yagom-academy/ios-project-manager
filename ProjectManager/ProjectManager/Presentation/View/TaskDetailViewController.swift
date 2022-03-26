import UIKit

final class TaskDetailViewController: UIViewController {
    @IBOutlet weak private var titleTextField: UITextField?
    @IBOutlet weak private var dueDatePicker: UIDatePicker?
    @IBOutlet weak private var bodyTextView: UITextView?

    var updateData: ((String, String, String) -> Void)?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        #if DEBUG
        print("init(coder:) has not been implemented")
        #endif
    }

    func setValue(title: String, dueDate: String, body: String) {
        self.titleTextField?.text = title
        self.dueDatePicker?.date = dueDate.formatToDate()
        self.bodyTextView?.text = body
    }

    @IBAction private func performDone(_ sender: Any) {
        guard let title = titleTextField?.text,
              title.isNotEmpty,
              let dueDate = dueDatePicker?.date.formatToString(),
              let body = bodyTextView?.text,
              let callback = updateData else {
            dismiss(animated: true, completion: nil)
            return
        }

        callback(title, dueDate, body)
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func performCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
