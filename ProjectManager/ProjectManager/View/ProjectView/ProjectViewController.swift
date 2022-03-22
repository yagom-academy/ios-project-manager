import UIKit
import RxSwift


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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ProjectTableViewController else { return }

        switch segue.identifier {
        case UIName.todoSegue:
            viewController.setup(
                viewModel: viewModel,
                titleText: Content.todoTitle,
                count: viewModel.todoCount,
                list: viewModel.todoList
            )
        case UIName.doingSegue:
            viewController.setup(
                viewModel: viewModel,
                titleText: Content.doingTitle,
                count: viewModel.doingCount,
                list: viewModel.doingList
            )
        case UIName.doneSegue:
            viewController.setup(
                viewModel: viewModel,
                titleText: Content.doneTitle,
                count: viewModel.doneCount,
                list: viewModel.doneList
            )
        default:
            break
        }
    }
    
    @IBAction private func addNewWork(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: UIName.workFormViewStoryboard, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            identifier: String(describing: WorkFormViewController.self)
        ) as? WorkFormViewController else {
            return
        }
        
        viewController.setup(
            selectedWork: nil,
            list: viewModel.todoList
        )
        viewController.modalPresentationStyle = .formSheet
        
        present(viewController, animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = Design.viewBackgroundColor
    }
    
}
