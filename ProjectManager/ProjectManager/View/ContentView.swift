import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: TaskListViewModel
    @State private var isPopoverPresentedForCreateTask = false
    
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
                isPopoverPresentedForCreateTask = true
            }, label: {
                Image(systemName: "plus")
                .sheet(isPresented: $isPopoverPresentedForCreateTask) {
                    TaskDetailView()
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
