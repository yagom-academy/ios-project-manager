import SwiftUI

struct TaskListRowView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    
    @State private var isShowTaskDetailView = false
    @State private var isShowUpdateTaskState = false
    @State private var firstMoveStatus: Task.ProgressStatus = .doing
    @State private var secondMoveStatus: Task.ProgressStatus = .done
    
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
                isShowTaskDetailView: $isShowTaskDetailView,
                isShowUpdateTaskState: $isShowUpdateTaskState,
                firstMoveStatus: $firstMoveStatus,
                secondMoveStatus: $secondMoveStatus,
                id: task.id,
                progressStatus: task.progressStatus
            )
        }
    }
}

struct TaskListRowTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .lineLimit(1)
    }
}

struct TaskListRowDescriptionView: View {
    let description: String
    
    var body: some View {
        Text(description)
            .font(.system(size: 17, weight: .regular, design: .rounded))
            .foregroundColor(.gray)
            .lineLimit(3)
    }
}

struct TaskListRowDeadlineView: View {
    let deadline: TimeInterval
    let progressStatus: Task.ProgressStatus
    
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

struct StatusChangePopoverView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    
    @Binding var isShowTaskDetailView: Bool
    @Binding var isShowUpdateTaskState: Bool
    @Binding var firstMoveStatus: Task.ProgressStatus
    @Binding var secondMoveStatus: Task.ProgressStatus
    
    let id: UUID
    let progressStatus: Task.ProgressStatus
    
    var body: some View {
        VStack {
            Button("Move to \(firstMoveStatus.name)") {
                viewModel.updateState(id: id, progressStatus: firstMoveStatus)
                self.isShowUpdateTaskState = false
            }
            .padding()
            Button("Move to \(secondMoveStatus.name)") {
                viewModel.updateState(id: id, progressStatus: secondMoveStatus)
                self.isShowUpdateTaskState = false
            }
            .padding()
            .onAppear {
                setButtonTitle()
            }
        }
    }
    
    private func setButtonTitle() {
        switch progressStatus {
        case .todo:
            firstMoveStatus = .doing
            secondMoveStatus = .done
        case .doing:
            firstMoveStatus = .todo
            secondMoveStatus = .done
        case .done:
            firstMoveStatus = .todo
            secondMoveStatus = .doing
        }
    }
}
