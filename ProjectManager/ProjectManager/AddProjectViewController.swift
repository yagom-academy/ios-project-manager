import UIKit

class AddProjectViewController: UIViewController {
    private let addView = ProjectFormView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = addView
    }
}
