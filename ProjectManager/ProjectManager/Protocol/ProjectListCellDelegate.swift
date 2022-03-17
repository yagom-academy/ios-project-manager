import UIKit

protocol ProjectListCellDelegate: AnyObject {
    func didTapTodoAction(_ project: Project?)
    func didTapDoingAction(_ project: Project?)
    func didTapDoneAction(_ project: Project?)
    func presentPopover(_ alert: UIAlertController)
}
