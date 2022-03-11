import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    let progressStatus: Task.ProgressStatus
    
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
        VStack {
            TaskListTitleView(progressStatus: progressStatus, taskList: taskList)
            TaskListContentView(taskList: taskList)
        }
    }
}

struct TaskListTitleView: View {
    let progressStatus: Task.ProgressStatus
    let taskList: [Task]
    
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

struct TaskListContentView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    let taskList: [Task]
    
    var body: some View {
        List {
            ForEach(taskList) { task in
                TaskListRowView(task: task)
            }
            .onDelete { indexSet in
                viewModel.deleteTask(taskList[indexSet.index])
            }
        }
    }
}
