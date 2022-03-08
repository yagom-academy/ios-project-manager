//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: ProjectManagerViewModel
    @State var isShowDetailScene: Bool = false
    @State var isShowPopover: Bool = false
    var tasks: [Task]
    var listName: String
    
    var body: some View {
        VStack {
            listTitle
            list
        }
    }
    
    var listTitle: some View {
        HStack {
            Text(listName)
                .font(.title)
            Spacer()
        }.padding()
    }
    
    var list: some View {
        List {
            ForEach(tasks) { task in
                Button {
                    self.isShowDetailScene.toggle()
                } label: {
                    TaskCellView(task: task)
                }.sheet(isPresented: $isShowDetailScene) {
                    // viewUpdate
                } content: {
                    DetailScene(viewModel: viewModel, task: task, showDetailScene: $isShowDetailScene)
                }
            }
            .onDelete { indexSet in
                self.viewModel.deleteTask(task: tasks[indexSet.first!])
            }
            .onLongPressGesture {
                print("show popover")
                self.isShowPopover = true
            }
            .popover(isPresented: $isShowPopover) {
                Text("go to Doing")
                Text("go to Done")
            }
        }
    }
}
