import UIKit

class SheetViewController: UIViewController {
    @IBOutlet weak var modeButtonItem: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    static let identifier = "SheetViewController"
    
    var currentItem = Item(title: "", description: "", progressStatus: "", dueDate: Int(Date().timeIntervalSince1970))
    var mode: String = ""
    var completionHandler: ((Item) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSheet()
    }
    
    private func configureSheet() {
        mode = determineModeStatus()
        self.modeButtonItem.title = mode
        
        if self.mode == Mode.edit {
            checkOfModifiable(status: false)
        } else {
            checkOfModifiable(status: true)
        }
        
        self.titleTextField.text = currentItem.title
        self.deadlineDatePicker.date = Date(timeIntervalSince1970: TimeInterval(currentItem.dueDate))
        self.descriptionTextView.text = currentItem.description
    }
    
    private func determineModeStatus() -> String {
        var modeStatus: String = ""
        if currentItem.title == "" && currentItem.description == "" {
            modeStatus = Mode.new
        } else {
            modeStatus = Mode.edit
        }
        return modeStatus
    }
    
    private func checkOfModifiable(status: Bool) {
        if status == true {
            self.titleTextField.isUserInteractionEnabled = true
            self.deadlineDatePicker.isUserInteractionEnabled = true
            self.descriptionTextView.isEditable = true
        } else {
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
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tappedModeButton(_ sender: UIBarButtonItem) {
        if sender.title == Mode.new {
            self.dismiss(animated: true, completion: nil)
        } else {
            sender.title = Mode.new

            checkOfModifiable(status: true)
        }
    }
    
    func setItem(with item: Item) {
        currentItem.title = item.title
        currentItem.dueDate = item.dueDate
        currentItem.progressStatus = item.progressStatus
        currentItem.description = item.description
        self.mode = Mode.edit
    }
}
