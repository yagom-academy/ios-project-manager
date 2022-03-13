import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var taskListViewiewModel: TaskListViewModel
    let progressStatus: Task.ProgressStatus
    
    var taskList: [Task] {
        switch progressStatus {
        case .todo:
            return taskListViewiewModel.todoTaskList
        case .doing:
            return taskListViewiewModel.doingTaskList
        case .done:
            return taskListViewiewModel.doneTaskList
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
    @EnvironmentObject private var taskListViewiewModel: TaskListViewModel
    let taskList: [Task]
    
    var body: some View {
        List {
            ForEach(taskList) { task in
                TaskListRowView(task: task)
            }
            .onDelete { indexSet in
                taskListViewiewModel.deleteTask(taskList[indexSet.index])
            }
        }
    }
}
