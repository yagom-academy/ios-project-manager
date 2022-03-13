import SwiftUI

struct ProjectManagerMainView: View {
    @State private var isShowTaskDetailView = false
    
    var body: some View {
        VStack {
            ProjectManagerMainTitleView(isShowTaskDetailView: $isShowTaskDetailView)
            Divider()
            ProjectManagerMainContentView()
        }
    }
}

private struct ProjectManagerMainTitleView: View {
    @Binding var isShowTaskDetailView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text("Project Manager")
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
