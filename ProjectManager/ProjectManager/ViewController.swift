import UIKit
import Firebase

class ViewController: UIViewController {
    
    lazy var rootReference = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        let itemReference = rootReference.child("test")
        itemReference.setValue("데이터베이스 연동 테스트")
    }
}
