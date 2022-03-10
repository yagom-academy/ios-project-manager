import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    @State private var isShowTaskDetailView = false
    
    var body: some View {
        VStack {
            title
            Divider()
            content
        }
    }
    
    private var title: some View {
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
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var content: some View {
        HStack {
            TaskListView(progressStatus: .todo)
            Divider()
            TaskListView(progressStatus: .doing)
            Divider()
            TaskListView(progressStatus: .done)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
