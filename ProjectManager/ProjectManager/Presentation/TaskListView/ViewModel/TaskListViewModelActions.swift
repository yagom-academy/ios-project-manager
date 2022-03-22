import Foundation

struct TaskListViewModelActions {
    let showTaskDetailToAddTask: () -> Void
    let showTaskDetailToEditTask: (Task) -> Void
}
