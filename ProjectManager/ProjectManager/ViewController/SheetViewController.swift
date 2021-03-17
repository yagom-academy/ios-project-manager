import UIKit

class SheetViewController: UIViewController {
    @IBOutlet weak var modeButtonItem: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    static let identifier = "SheetViewController"
    
    var currentItem = Item(title: "", description: "", progressStatus: "", dueDate: Int(Date().timeIntervalSince1970))
    var mode: Mode?
    var completionHandler: ((Item) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSheet()
    }
    
    private func configureSheet() {
        if let mode = self.mode {
            self.modeButtonItem.title = mode.barButtonTitle
            checkOfModifiable(status: mode)
        }
        
        self.titleTextField.text = currentItem.title
        self.deadlineDatePicker.date = Date(timeIntervalSince1970: TimeInterval(currentItem.dueDate))
        self.descriptionTextView.text = currentItem.description
    }
    
    private func checkOfModifiable(status: Mode) {
        switch status {
        case .editable:
            self.titleTextField.isUserInteractionEnabled = true
            self.deadlineDatePicker.isUserInteractionEnabled = true
            self.descriptionTextView.isEditable = true
        case .uneditable:
            self.titleTextField.isUserInteractionEnabled = false
            self.deadlineDatePicker.isUserInteractionEnabled = false
            self.descriptionTextView.isEditable = false
        }
    }
    
    func updateItemHandler(handler: @escaping (_ item: Item) -> Void) {
        completionHandler = handler
    }
    
    @IBAction private func tappedDoneButton(_ sender: Any) {
        guard let itemTitle = titleTextField.text,
              let itemDescription = descriptionTextView.text else {
            return
        }
        
        currentItem.title = itemTitle
        currentItem.description = itemDescription
        currentItem.dueDate = Int(deadlineDatePicker.date.timeIntervalSince1970)
        
        if let completionHandler = completionHandler {
            completionHandler(currentItem)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tappedModeButton(_ sender: UIBarButtonItem) {
        if sender.title == Mode.editable.barButtonTitle {
            self.dismiss(animated: true, completion: nil)
        } else {
            sender.title = Mode.editable.barButtonTitle
            mode = .editable
            checkOfModifiable(status: Mode.editable)
        }
    }
    
    func setItem(with item: Item) {
        currentItem.title = item.title
        currentItem.dueDate = item.dueDate
        currentItem.progressStatus = item.progressStatus
        currentItem.description = item.description
    }
}
