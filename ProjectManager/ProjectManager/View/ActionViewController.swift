import UIKit

class ActionViewController: UIViewController {
    private var viewModel: ProjectViewModel?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bodyTextView: UITextView!
    
    convenience init?(coder: NSCoder, viewModel: ProjectViewModel) {
        self.init(coder: coder)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.layer.borderColor = UIColor.systemGray6.cgColor
        titleTextField.layer.borderWidth = 1
        bodyTextView.layer.borderColor = UIColor.systemGray6.cgColor
        bodyTextView.layer.borderWidth = 1
    }
}
