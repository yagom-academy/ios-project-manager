import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    let progressStatus: Task.ProgressStatus
    
    fileprivate var taskList: [Task] {
        switch progressStatus {
        case .todo:
            return taskListViewModel.todoTaskList
        case .doing:
            return taskListViewModel.doingTaskList
        case .done:
            return taskListViewModel.doneTaskList
        }
    }
    
    var body: some View {
        VStack {
            TaskListTitleView(progressStatus: progressStatus, taskList: taskList)
            TaskListContentView(taskList: taskList)
        }
    }
}

private struct TaskListTitleView: View {
    fileprivate let progressStatus: Task.ProgressStatus
    fileprivate let taskList: [Task]
    
    var body: some View {
        HStack {
            Text("\(progressStatus.name)")
                .font(.title2)
                .padding(.leading)
            Spacer()
            Text("\(taskList.count)")
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct TaskListContentView: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    fileprivate let taskList: [Task]
    
    var body: some View {
        List {
            ForEach(taskList) { task in
                TaskListRowView(task: task)
            }
            .onDelete { indexSet in
                taskListViewModel.deleteTask(taskList[indexSet.index].id)
            }
        }
    }
}
