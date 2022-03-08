import UIKit

class EditProjectDetailViewController: ProjectDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        self.navigationItem.title = TitleText.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton))
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    @objc private func didTapDoneButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapEditButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Constants

private extension EditProjectDetailViewController {
    enum TitleText {
        static let navigationBarTitle = "TODO"
    }
}
