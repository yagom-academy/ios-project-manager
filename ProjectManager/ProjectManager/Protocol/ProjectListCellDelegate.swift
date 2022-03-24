import UIKit

protocol ProjectListCellDelegate: AnyObject {
    func didTapTodoAction(_ projectState: ProjectState?, indexPath: IndexPath?)
    func didTapDoingAction(_ projectState: ProjectState?, indexPath: IndexPath?)
    func didTapDoneAction(_ projectState: ProjectState?, indexPath: IndexPath?)
    func presentPopover(_ alert: UIAlertController)
}
