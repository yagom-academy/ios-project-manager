import UIKit

class ActionViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.layer.borderColor = UIColor.systemGray6.cgColor
        titleTextField.layer.borderWidth = 1
        bodyTextView.layer.borderColor = UIColor.systemGray6.cgColor
        bodyTextView.layer.borderWidth = 1
    }
}
