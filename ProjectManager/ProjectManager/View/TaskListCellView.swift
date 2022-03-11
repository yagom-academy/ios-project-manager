import SwiftUI

struct TaskListCellView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    
    @State private var isShowTaskDetailView = false
    @State private var isShowUpdateTaskState = false
    @State private var firstMoveStatus: ProgressStatus = .doing
    @State private var secondMoveStatus: ProgressStatus = .done
    
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            title
            descrition
            deadline
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
            statusChangePopover
        }
    }
    
    private var title: some View {
        Text(task.title)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .lineLimit(1)
    }
    
    private var descrition: some View {
        Text(task.description)
            .font(.system(size: 17, weight: .regular, design: .rounded))
            .foregroundColor(.gray)
            .lineLimit(3)
    }
    
    private var deadline: some View {
        let deadlineText = Text(task.deadline.formattedDate)
        let currentTime = Date().timeIntervalSince1970
        
        if task.progressStatus != .done, task.deadline < currentTime {
            return deadlineText
                .foregroundColor(Color.red)
                .font(.system(size: 15, weight: .regular, design: .rounded))
        } else {
            return deadlineText
                .font(.system(size: 15, weight: .regular, design: .rounded))
        }
    }
    
    private var statusChangePopover: some View {
        VStack {
            Button("Move to \(firstMoveStatus.name)") {
                viewModel.updateState(id: task.id, progressStatus: firstMoveStatus)
                self.isShowUpdateTaskState = false
            }
            .padding()
            Button("Move to \(secondMoveStatus.name)") {
                viewModel.updateState(id: task.id, progressStatus: secondMoveStatus)
                self.isShowUpdateTaskState = false
            }
            .padding()
            .onAppear {
                setButtonTitle()
            }
        }
    }
    
    private func setButtonTitle() {
        switch task.progressStatus {
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
