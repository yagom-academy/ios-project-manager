import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    let taskStatus: TaskStatus
    
    fileprivate var taskList: [Task] {
        switch taskStatus {
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
            TaskListTitleView(taskStatus: taskStatus, taskList: taskList)
            TaskListContentView(taskList: taskList)
        }
    }
}

private struct TaskListTitleView: View {
    fileprivate let taskStatus: TaskStatus
    fileprivate let taskList: [Task]
    
    var body: some View {
        HStack {
            Text("\(taskStatus.name)")
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
                let task = taskList[indexSet.index]
                taskListViewModel.deleteTask(id: task.id, title: task.title, taskStatus: task.progressStatus)
            }
            .alert(item: $taskListViewModel.errorAlert) { error in
                Alert(title: Text("Error".localized()), message: Text(error.message))
            }
        }
    }
}
