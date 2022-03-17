import SwiftUI

struct ProjectManagerMainView: View {
    @ObservedObject var networkCheckManager: NetworkCheckManager
    @State private var isShowTaskDetailView = false
    @State private var isShowTaskHistoryView = false
    
    var body: some View {
        VStack {
            ProjectManagerMainTitleView(
                isShowTaskDetailView: $isShowTaskDetailView,
                isShowTaskHistoryView: $isShowTaskHistoryView
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
    @Binding var isShowTaskDetailView: Bool
    @Binding var isShowTaskHistoryView: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                isShowTaskDetailView = true
            }, label: {
                Text("Histroy".localized())
                    .popover(isPresented: $isShowTaskDetailView) {
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
    
    var body: some View {
        Text("History")
    }
}

private struct ProjectManagerMainContentView: View {
    var body: some View {
        HStack {
            ForEach(Task.ProgressStatus.allCases) { status in
                TaskListView(progressStatus: status)
                if status != .done {
                    Divider()
                }
            }
        }
    }
}
