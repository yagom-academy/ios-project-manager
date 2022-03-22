import Foundation
import UIKit

struct TaskListViewModelActions {
    let showTaskDetailToAddTask: () -> Void
    let showTaskDetailToEditTask: (Task) -> Void
    let presentPopover: (UIAlertController) -> Void
}
