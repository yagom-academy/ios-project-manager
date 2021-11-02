//
//  ListColumn.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/27.
//

import SwiftUI

struct ListColumn: View {
    
    @State var isShowModal: Bool = false
    
    var tasks: [Task]
    var taskState: TaskState
    
    var body: some View {
        List {
            ListTitle(title: String(describing: taskState),
                      countOfTask: tasks.count.description)
                .listRowInsets(EdgeInsets(top: 0,
                                          leading: -16,
                                          bottom: 0,
                                          trailing: -16))
            ForEach(tasks) { task in
                ListRow(task: task)
                    .listRowInsets(EdgeInsets(top: 8,
                                              leading: -16,
                                              bottom: 0,
                                              trailing: -16))
                    .onTapGesture {
                        self.isShowModal = true
                    }
                    .sheet(isPresented: self.$isShowModal, content: {
                        ModalView()
                    })
            }
        }
        .listStyle(InsetListStyle())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListColumn(
            tasks: [
                Task(title: "test", description: "descp", date: Date(), state: .doing),
                Task(title: "test", description: "descp", date: Date(), state: .doing),
                Task(title: "test", description: "descp", date: Date(), state: .doing)
            ],
            taskState: TaskState.todo)
    }
}
