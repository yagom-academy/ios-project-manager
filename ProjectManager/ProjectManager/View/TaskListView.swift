import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var viewModel: TaskListViewModel
    
    let progressStatus: ProgressStatus
    
    var taskList: [Task] {
        switch progressStatus {
        case .todo:
            return viewModel.todoTaskList
        case .doing:
            return viewModel.doingTaskList
        case .done:
            return viewModel.doneTaskList
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("\(progressStatus.name) (\(taskList.count))").font(.title2)) {
                ForEach(taskList) { task in
                    TaskListCellView(task: task)
                }
            }
        }
    }
}
