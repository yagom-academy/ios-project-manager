import UIKit

class AddProjectDetailViewController: ProjectDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    @objc private func didTapDoneButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Constants

private extension AddProjectDetailViewController {
    enum TitleText {
        static let navigationBarTitle = "TODO"
    }
}
