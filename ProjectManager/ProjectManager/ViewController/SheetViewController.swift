import UIKit

class SheetViewController: UIViewController {
    static let identifier = "SheetViewController"
    
    @IBOutlet weak var modeButtonItem: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var currentItem = Item(title: "", description: "", progressStatus: "TODO", timeStamp: Int(Date().timeIntervalSince1970))
    var mode: Mode?
    var completionHandler: ((Item) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSheet()
    }
    
    @IBAction private func tappedDoneButton(_ sender: Any) {
        guard let itemTitle = titleTextField.text,
              let itemDescription = descriptionTextView.text else {
            return
        }
        
        currentItem.title = itemTitle
        currentItem.description = itemDescription
        currentItem.timeStamp = Int(deadlineDatePicker.date.timeIntervalSince1970)
        
        if let completionHandler = completionHandler {
            completionHandler(currentItem)
        }
        
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
    
    func updateItemHandler(handler: @escaping (_ item: Item) -> Void) {
        completionHandler = handler
    }
    
    func setItem(with item: Item) {
        currentItem.title = item.title
        currentItem.timeStamp = item.timeStamp
        currentItem.progressStatus = item.progressStatus
        currentItem.description = item.description
    }
}

// MARK: - configure & checkOfModify

extension SheetViewController {
    private func configureSheet() {
        if let mode = self.mode {
            self.modeButtonItem.title = mode.barButtonTitle
            checkOfModifiable(status: mode)
        }
        
        self.titleTextField.text = currentItem.title
        self.deadlineDatePicker.date = Date(timeIntervalSince1970: TimeInterval(currentItem.timeStamp))
        self.descriptionTextView.text = currentItem.description
    }
    
    private func checkOfModifiable(status: Mode) {
        switch status {
        case .editable:
            self.titleTextField.isUserInteractionEnabled = true
            self.deadlineDatePicker.isUserInteractionEnabled = true
            self.descriptionTextView.isEditable = true
        case .readOnly:
            self.titleTextField.isUserInteractionEnabled = false
            self.deadlineDatePicker.isUserInteractionEnabled = false
            self.descriptionTextView.isEditable = false
        }
    }
}
