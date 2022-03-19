import UIKit

class DetailUpdateViewController: UIViewController {
    
    let shareView = ProjectDetailUIView()
    var viewModel: DetailUpdateViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(shareView)
    }
}
