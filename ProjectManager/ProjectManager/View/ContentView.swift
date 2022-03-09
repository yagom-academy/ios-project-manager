import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var viewModel: TaskListViewModel
    @State var isPopoverPresentedForCreateTask = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
                }
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
