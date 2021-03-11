import UIKit

class SheetViewController: UIViewController {
    @IBOutlet weak var modeButtonItem: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    static let identifier = "SheetViewController"
    
    private enum Mode {
        static let cancel = "Cancel"
        static let edit = "Edit"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modeButtonItem.title = Mode.cancel
    }
    
    @IBAction func tappedDoneButton(_ sender: Any) {
        // 새로운 글 등록 or 기존의 글 수정 -> 내용 저장하기
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedModeButton(_ sender: UIBarButtonItem) {
        if sender.title == Mode.cancel {
            self.dismiss(animated: true, completion: nil)
        } else {
            sender.title = Mode.cancel
            //기존의 글 수정 및 Done -> update 내용 저장하기
        }
    }

}
