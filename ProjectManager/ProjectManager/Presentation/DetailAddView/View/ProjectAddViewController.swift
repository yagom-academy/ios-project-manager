import UIKit

class ProjectAddViewController: UIViewController {
    
    let shareView = ProjectDetailUIView()
    
    override func loadView() {
        view = shareView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
