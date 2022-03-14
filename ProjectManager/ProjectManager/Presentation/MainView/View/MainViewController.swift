import UIKit

final class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
    private var shareView = MainUIView()
    
    // MARK: - lifeCycle
    
    override func loadView() {
        self.view = shareView
        self.view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
    }
    // MARK: - method 
    private func configureNavigationItems() {
        self.navigationItem.title = "ProjectManager"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didtappedRightBarButton)
        )
    }
    
    @objc func didtappedRightBarButton() {
        viewModel?.coordinator?.occuredEvent(with: .buttonTapped)
    }
}
    



