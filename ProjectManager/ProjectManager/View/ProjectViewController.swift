import UIKit
import RxSwift
import RxCocoa


private enum UIName {
    static let workFormViewStoryboard = "WorkFormView"
    static let todoSegue = "todoSegue"
    static let doingSegue = "doingSegue"
    static let doneSegue = "doneSegue"
}

private enum Content {
    static let todoTitle = "TODO"
    static let doingTitle = "DOING"
    static let doneTitle = "DONE"
}

private enum Design {
    static let tableViewBackgroundColor: UIColor = .systemGray5
    static let viewBackgroundColor: UIColor = .systemGray6
}

final class ProjectViewController: UIViewController {
    
    private let viewModel = ProjectViewModel()
    private var disposeBag = DisposeBag()
    private let formSheetViewStorboardName = UIName.workFormViewStoryboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let test = segue.destination as? ProjectTableViewController else { return }

        switch segue.identifier {
        case UIName.todoSegue:
            test.titleText = Content.todoTitle
            test.count = viewModel.todoCount
            test.list = viewModel.todoList
        case UIName.doingSegue:
            test.titleText = Content.doingTitle
            test.count = viewModel.doingCount
            test.list = viewModel.doingList
        case UIName.doneSegue:
            test.titleText = Content.doneTitle
            test.count = viewModel.doneCount
            test.list = viewModel.doneList
        default:
            break
        }
    }
    
    @IBAction private func addNewWork(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: formSheetViewStorboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            identifier: String(describing: WorkFormViewController.self)
        ) { coder in
            WorkFormViewController(coder: coder, viewModel: self.viewModel)
        }
        viewController.modalPresentationStyle = .formSheet
        
        present(viewController, animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = Design.viewBackgroundColor
    }
    
}
