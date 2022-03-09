import SwiftUI

struct TaskListCellView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    
    @State private var isPopoverPresentedForUpdateTask = false
    @State private var isPopoverPresentedForUpdateTaskState = false
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
            self.isPopoverPresentedForUpdateTaskState = false
            self.isPopoverPresentedForUpdateTask = true
        }
        .sheet(isPresented: $isPopoverPresentedForUpdateTask, onDismiss: nil) {
            TaskDetailView(task: task)
        }
        .onLongPressGesture {
            self.isPopoverPresentedForUpdateTaskState = true
        }
        .popover(isPresented: $isPopoverPresentedForUpdateTaskState) {
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
                viewModel.updateState(firstMoveStatus, to: task)
                self.isPopoverPresentedForUpdateTaskState = false
            }
            .padding()
            Button("Move to \(secondMoveStatus.name)") {
                viewModel.updateState(secondMoveStatus, to: task)
                self.isPopoverPresentedForUpdateTaskState = false
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

struct TaskListCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListCellView(task: Task(title: "title", description: "description", deadline: Date()))
    }
}
