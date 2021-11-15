//
//  ContentView.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State var isShowModal: Bool = false
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(red: 242 / 255,
                                                           green: 242 / 255,
                                                           blue: 247 / 255,
                                                           alpha: 1.0)
    }
    
    var body: some View {
        NavigationView {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8) {
                ListColumn(taskState: TaskState.todo)
                ListColumn(taskState: TaskState.doing)
                ListColumn(taskState: TaskState.done)
            }
            .background(Color(red: 216 / 255, green: 216 / 255, blue: 216 / 255))
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                self.isShowModal = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $isShowModal, content: {
                ModalView(modalState: .add,
                          task: Task(title: "", description: "", date: Date(), state: .todo))
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TaskViewModel())
    }
}
