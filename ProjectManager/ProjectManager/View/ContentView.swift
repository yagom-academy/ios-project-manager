import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: TaskListViewModel
    @State var isPopoverPresentedForCreateTask = false
    
    var body: some View {
        VStack {
            title
            content
        }
    }
    
    var title: some View {
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
        .padding()
    }
    
    var content: some View {
        HStack {
            TaskListView(progressStatus: .todo)
            TaskListView(progressStatus: .doing)
            TaskListView(progressStatus: .done)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
