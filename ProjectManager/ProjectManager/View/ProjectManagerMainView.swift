import SwiftUI

struct ProjectManagerMainView: View {
    @ObservedObject var networkCheckManager: NetworkCheckManager
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
        .alert(isPresented: $networkCheckManager.isNotConnected) {
            Alert(
                title: Text("Network is Not Connected".localized()),
                message: Text("It looks like you're not connected to the internet".localized())
            )
        }
    }
}

private struct ProjectManagerMainTitleView: View {
    @Binding var isShowTaskHistoryView: Bool
    @Binding var isShowTaskDetailView: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                isShowTaskHistoryView = true
            }, label: {
                Text("Histroy".localized())
                    .popover(isPresented: $isShowTaskHistoryView) {
                        TaskHistoryView()
                }
            })
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

private struct TaskHistoryView: View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    
    var body: some View {
        List {
            ForEach(taskListViewModel.taskHistory) { taskHistory in
                VStack(alignment: .leading) {
                    Text(taskHistory.description)
                        .font(.title2)
                        .foregroundColor(.black)
                    Text(taskHistory.date.formatString(dateStyle: .short, timeStyle: .short))
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(width: 500, height: 500, alignment: .leading)
    }
}

private struct ProjectManagerMainContentView: View {
    var body: some View {
        HStack {
            ForEach(Task.ProgressStatus.allCases) { status in
                TaskListView(taskStatus: status)
                if status != .done {
                    Divider()
                }
            }
        }
    }
}
