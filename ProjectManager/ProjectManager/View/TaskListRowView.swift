import SwiftUI

struct TaskListRowView: View {
    @State private var isShowTaskDetailView = false
    @State private var isShowUpdateTaskState = false
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TaskListRowTitleView(title: task.title)
            TaskListRowDescriptionView(description: task.description)
            TaskListRowDeadlineView(deadline: task.deadline, progressStatus: task.progressStatus)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            self.isShowUpdateTaskState = false
            self.isShowTaskDetailView = true
        }
        .sheet(isPresented: $isShowTaskDetailView, onDismiss: nil) {
            TaskDetailView(isShowTaskDetailView: $isShowTaskDetailView, task: task)
        }
        .onLongPressGesture {
            self.isShowUpdateTaskState = true
        }
        .popover(isPresented: $isShowUpdateTaskState) {
            StatusChangePopoverView(
                isShowUpdateTaskState: $isShowUpdateTaskState,
                task: task
            )
        }
    }
}

private struct TaskListRowTitleView: View {
    fileprivate let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .lineLimit(1)
    }
}

private struct TaskListRowDescriptionView: View {
    fileprivate let description: String
    
    var body: some View {
        Text(description)
            .font(.system(size: 17, weight: .regular, design: .rounded))
            .foregroundColor(.gray)
            .lineLimit(3)
    }
}

private struct TaskListRowDeadlineView: View {
    fileprivate let deadline: TimeInterval
    fileprivate let progressStatus: Task.ProgressStatus
    
    var body: some View {
        let deadlineText = Text(deadline.formattedDate)
        let currentTime = Date().timeIntervalSince1970
        
        if progressStatus != .done, deadline < currentTime {
            return deadlineText
                .foregroundColor(Color.red)
                .font(.system(size: 15, weight: .regular, design: .rounded))
        } else {
            return deadlineText
                .font(.system(size: 15, weight: .regular, design: .rounded))
        }
    }
}

private struct StatusChangePopoverView: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    @Binding var isShowUpdateTaskState: Bool
    let task: Task
    
    var body: some View {
        VStack {
            ForEach(taskListViewModel.changeableStatusList(from: task.progressStatus)) { status in
                Button("Move to \(status.name)") {
                    taskListViewModel.updateState(id: task.id, progressStatus: status)
                    self.isShowUpdateTaskState = false
                }
                .padding()
            }
        }
    }
}
