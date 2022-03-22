import SwiftUI

struct ProjectManagerMainView: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    @State private var isShowTaskDetailView = false
    @State private var isShowTaskHistoryView = false
    
    var body: some View {
        VStack {
            ProjectManagerMainTitleView(
                isShowTaskHistoryView: $isShowTaskHistoryView,
                isShowTaskDetailView: $isShowTaskDetailView
            )
            Divider()
            ProjectManagerMainContentView()
        }
        .alert(item: $taskListViewModel.errorAlert) { error in
            Alert(title: Text("Error".localized()), message: Text(error.message.localized()))
        }
    }
}

private struct ProjectManagerMainTitleView: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    @Binding var isShowTaskHistoryView: Bool
    @Binding var isShowTaskDetailView: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                isShowTaskHistoryView = true
            }, label: {
                Text("Histroy".localized())
                    .popover(isPresented: $isShowTaskHistoryView) {
                        TaskHistoryListView()
                    }
            })
                .disabled((taskListViewModel.taskHistory.isEmpty))
            Spacer()
            Text("Project Manager".localized())
                .padding(.leading)
            Spacer()
            Button(action: {
                isShowTaskDetailView = true
            }, label: {
                Image(systemName: "plus")
                    .sheet(isPresented: $isShowTaskDetailView) {
                        TaskDetailView(isShowTaskDetailView: $isShowTaskDetailView)
                    }
            })
        }
        .padding([.horizontal, .top])
    }
}

private struct TaskHistoryListView: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    
    var body: some View {
        VStack {
            ForEach(taskListViewModel.taskHistory) { taskHistory in
                TaskHistoryRowView(taskHistory: taskHistory)
                    .frame(width: 500, alignment: .leading)
                    .padding(12)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(12)
            }
        }
        .padding(16)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

private struct TaskHistoryRowView: View {
    let taskHistory: TaskHistory
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(taskHistory.description)
                .font(.title3)
                .foregroundColor(.primary)
                .lineLimit(2)
            Text(taskHistory.date.formatString(dateStyle: .short, timeStyle: .short))
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

private struct ProjectManagerMainContentView: View {
    var body: some View {
        HStack {
            ForEach(TaskStatus.allCases) { status in
                TaskListView(taskStatus: status)
                if status != .done {
                    Divider()
                }
            }
        }
    }
}
