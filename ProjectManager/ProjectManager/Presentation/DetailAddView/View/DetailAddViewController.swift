import UIKit

class DetailAddViewController: UIViewController {
    
    private let shareView = ProjectDetailUIView()
    var viewModel: DetailAddViewModel?
    
    override func loadView() {
        view = shareView
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItem() 
    }
    
    private func configureNavigationItem() {
        self.navigationItem.title = "TODO"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didtappedRightBarButton))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didtappedleftBarButton))
    }
    
    @objc func didtappedRightBarButton() {
        
    }
    
    @objc func didtappedleftBarButton() {
        
    }
    

}
